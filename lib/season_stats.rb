require_relative './helper_methods'
class SeasonStats
  attr_reader :game_teams,
              :teams,
              :games
  def initialize(filepath1 = nil, filepath2 = nil, filepath3 = nil)
    @game_teams = HelperMethods.load_game_teams(filepath1)
    @games      = HelperMethods.load_games(filepath2)
    @teams      = HelperMethods.load_teams(filepath3)
  end

  def find_this_season(the_season)
    this_season = []
    @games.find_all do |game_in_season|
      if game_in_season.season == the_season
        this_season << game_in_season
      end
    end
    this_season
  end

  def find_games_by_game_id(games_this_season)
    result_games_by_game_id = {}
    games_this_season.each do |game_this_season|
      if result_games_by_game_id[game_this_season.game_id]
        result_games_by_game_id[game_this_season.game_id] += game_this_season.game_id
      else
        result_games_by_game_id[game_this_season.game_id] = game_this_season.game_id
      end
    end
    result_games_by_game_id.values
  end

  def find_game_list(games_with_key_as_game_id, game_ids_this_season)
    game_list = []
    games_with_key_as_game_id.each do |game_id, games|
      if game_ids_this_season.include?(game_id.to_s)
        game_list << games
      end
    end
    game_list.flatten
  end

  def find_teams_by_game_id(game_teams)
    game_teams.group_by {|game_team| game_team.game_id}
  end

  def find_team_and_accuracy(teams_by_id)
    team_and_accuracy = {}
    teams_by_id.each do |team|
      goals_by_team = team[1].sum { |the_goals| the_goals.goals.to_f }
      shots_by_team = team[1].sum { |the_shots| the_shots.shots.to_f}
      team_and_accuracy[team[0]] = goals_by_team / shots_by_team
    end
    team_and_accuracy
  end

  def find_team_and_tackles(teams_by_id)
    team_and_total_tackles = {}
    teams_by_id.each do |team|
      goals_by_team = team[1].sum {|the_tackles| the_tackles.tackles}
      team_and_total_tackles[team[0]] = goals_by_team
    end
    team_and_total_tackles
  end

  def find_coach_games(season_games2)
    coach_games = {}
    game_teams.each do |season_game|
      season_games2.each do |game_id|
        if season_game.game_id == game_id.to_i
          if coach_games[season_game.head_coach]
            coach_games[season_game.head_coach] += "," + season_game.result
          else
            coach_games[season_game.head_coach] = season_game.result
          end
        end
      end
    end
    coach_games
  end

  def find_coach_and_wins(coach_games_results)
    coach_and_wins = []
    coach_games_results.each do |coach_name, game_results|
      game_results = game_results.split(",")
      coach_wins = game_results.find_all {|game_result| game_result == "WIN" }
      coach_and_wins << [coach_name , (2 * coach_wins.count) / (2 * game_results.count.to_f) * 100.round(2)]
    end
    coach_and_wins
  end

  def find_head_coach_best_worst(games, game_teams, the_season, flag)
    coach_games_results = {}
    coach_and_wins =
    games_grouped_by_season = games.group_by { |game| game.season }
    season_games = games_grouped_by_season.map {|season, game_grouped_by_season| game_grouped_by_season.find_all { |season_game| season_game.season == the_season } }.flatten
    this_season_games = season_games.group_by { |season_game| season_game.season }
    season_games2 = this_season_games.map {|season, game| game.map { |x|  x.game_id } }.flatten
    coach_games = find_coach_games(season_games2)
    coach_games.each { |coach_name, game_results| coach_games_results[coach_name] = game_results }
    coach_and_wins = find_coach_and_wins(coach_games_results)
    coach_and_wins
  end

  def winningest_coach(the_season)
    find_head_coach_best_worst(@games, @game_teams, the_season, "WIN").max_by {|x| x[1]}[0]
  end

  def worst_coach(the_season)
    find_head_coach_best_worst(@games, @game_teams, the_season, "WIN").min_by {|x| x[1]}[0]
  end

  def most_accurate_team(the_season)
    game_teams_by_id = find_teams_by_game_id(game_teams)
    this_season = find_this_season(the_season)
    this_season_game_ids = find_games_by_game_id(this_season)
    game_list = find_game_list(game_teams_by_id, this_season_game_ids)
    teams_by_id = HelperMethods.find_teams_by_team_id(game_list)
    team_and_accuracy = find_team_and_accuracy(teams_by_id)
    best_team = HelperMethods.largest_hash_value(team_and_accuracy)
    team_name = HelperMethods.find_team_name(best_team)
    team_name[0]
  end

  def least_accurate_team(the_season)
    game_teams_by_id = find_teams_by_game_id(game_teams)
    this_season = find_this_season(the_season)
    this_season_game_ids = find_games_by_game_id(this_season)
    game_list = find_game_list(game_teams_by_id, this_season_game_ids)
    teams_by_id = HelperMethods.find_teams_by_team_id(game_list)
    team_and_accuracy = find_team_and_accuracy(teams_by_id)
    worst_team = HelperMethods.smallest_hash_value(team_and_accuracy)
    team_name = HelperMethods.find_team_name(worst_team)
    team_name[0]
  end

  def most_tackles(the_season)
    this_season = find_this_season(the_season)
    game_teams_by_id = find_teams_by_game_id(game_teams)
    this_season_game_ids = find_games_by_game_id(this_season)
    game_list = find_game_list(game_teams_by_id, this_season_game_ids)
    teams_by_id = HelperMethods.find_teams_by_team_id(game_list)
    team_and_total_tackles = find_team_and_tackles(teams_by_id)
    top_tacklers = HelperMethods.largest_hash_value(team_and_total_tackles)
    highest_tacklers = HelperMethods.find_team_name(top_tacklers)
    highest_tacklers[0]
  end

  def fewest_tackles(the_season)
    this_season = find_this_season(the_season)
    game_teams_by_id = find_teams_by_game_id(game_teams)
    this_season_game_ids = find_games_by_game_id(this_season)
    game_list = find_game_list(game_teams_by_id, this_season_game_ids)
    teams_by_id = HelperMethods.find_teams_by_team_id(game_list)
    team_and_total_tackles = find_team_and_tackles(teams_by_id)
    bottom_tacklers = HelperMethods.smallest_hash_value(team_and_total_tackles)
    lowest_tacklers = HelperMethods.find_team_name(bottom_tacklers)
    lowest_tacklers[0]
  end
end
