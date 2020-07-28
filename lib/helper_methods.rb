require 'CSV'
require_relative './game_teams'
require_relative './game'
require_relative './team'
require 'pry'

module HelperMethods

  def self.load_game_teams(filepath1)
    game_teams = []
    CSV.foreach(filepath1, headers: true, header_converters: :symbol) do |data|
      game_teams << GameTeams.new(data)
    end
    game_teams
  end

  def self.load_games(filepath2)
    @games = []
    CSV.foreach(filepath2, headers: true, header_converters: :symbol) do |data|
      @games << Game.new(data)
    end
    @games
  end

  def self.load_teams(filepath3)
    @teams = []
    CSV.foreach(filepath3, headers: true, header_converters: :symbol) do |data|
      @teams << Team.new(data)
    end
    @teams
  end

  def self.game_teams_find_by_game_id(game_id)
    game_teams.find do |season_stat|
      season_stat.game_id == game_id
    end
  end

  def self.teams_find_by_team_id(team_id)
    teams.find do |season_stat|
      season_stat.team_id == team_id
    end
  end

  def self.largest_hash_value(hash)
    hash.max_by{|k,v| v}
  end

  def self.smallest_hash_value(hash)
    hash.min_by{|k,v| v}
  end

  def self.find_win_games(game_teams)
    game_teams.find_all do |game_team|
      game_team.result == "WIN"
    end
  end

  def self.find_tie_games(game_teams)
    game_teams.find_all do |game_team|
      game_team.result == "TIE"
    end
  end

  def self.find_lose_games(game_teams)
    game_teams.find_all do |game_team|
      game_team.result == "LOSS"
    end
  end

  def self.find_away_games(game_teams)
    game_teams.find_all do |game_team|
      game_team.hoa == "away"

    end
  end

  def self.find_home_games(game_teams)
    game_teams.find_all do |game_team|
      game_team.hoa == "home"
    end
  end

  def self.find_result_games_with_key_as_game_id(result_games)
    result_games.group_by do |game_result|
      game_result.game_id.to_s
    end
  end

  def self.find_this_season(the_season)
    this_season = []
    @games.find_all do |game_in_season|
      if game_in_season.season == the_season
        this_season << game_in_season
      end
    end
    this_season
  end

  def self.find_result_games_this_season(this_season, result_games_with_key_as_game_id)
    result_games_this_season = []
    this_season.each do |the_game|
      if result_games_with_key_as_game_id.keys.any?(the_game.game_id) == true
        result_games_this_season << the_game
      end
    end

    # binding.pry
    result_games_this_season.values
  end

  # def self.find_result_games_this_season(this_season, result_games_with_key_as_game_id)
  # result_games_this_season = []
  # this_season.each do |the_game|
  #   if result_games_with_key_as_game_id.keys.any?(the_game.game_id) == true
  #     result_games_this_season << the_game
  #   end
  # end
  # result_games_this_season
  # binding.pry
  # end

  def self.find_games_by_game_id(games_this_season)
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



  def self.find_game_list(games_with_key_as_game_id, game_ids_this_season)
    game_list = []
    games_with_key_as_game_id.each do |game_id, games|
      if game_ids_this_season.include?(game_id.to_s)
        game_list << games
      end
    end
    # binding.pry
    game_list.flatten
  end

  def self.find_game_list_with_reduce(games_with_key_as_game_id, games_by_game_id)
    game_list = []
    games_with_key_as_game_id.find_all do |game_result|
      if games_by_game_id.any?(game_result[0]) == true
        game_list << game_result[1].first
      end
    end
    game_list
  end

  def self.find_teams_by_team_id(game_teams)
    game_teams.group_by do |game_team|
      game_team.team_id
    end
  end

  def self.find_teams_by_game_id(game_teams)
    game_teams.group_by do |game_team|
      game_team.game_id
    end
  end

  # def self.find_team_and_results(teams_by_id, this_season)
  #   find_team_and_results = {}
  #   teams_by_id.each do |team|
  #     find_team_and_results[team[0]] = (team[1].count.to_f * 100) / this_season.count.to_f
  #   end
  #
  #   find_team_and_results
  # end

  def self.find_team_and_results(teams_by_id_losses, teams_by_id_wins, teams_by_id_tie)
    find_team_and_results = {}
    teams_by_id_tie.each do |team_tie|
      teams_by_id_wins.each do |team_win|
        teams_by_id_losses.each do |team_loss|
          unless find_team_and_results[team_loss[0]]
            find_team_and_results[team_loss[0]] = ((team_loss[1].count.to_f) / (team_loss[1].count.to_f + team_win[1].count.to_f + team_tie[1].count.to_f) * 100).round(2)
          end
        end
      end
    end
    # binding.pry

    find_team_and_results
  end

  def self.find_team_and_accuracy(teams_by_id)
    team_and_accuracy = {}
    teams_by_id.each do |team|
      goals_by_team = team[1].sum do |the_goals|
        the_goals.goals.to_f
      end
      shots_by_team = team[1].sum do |the_shots|
        the_shots.shots.to_f
      end
      team_and_accuracy[team[0]] = goals_by_team / shots_by_team
    end
    team_and_accuracy
  end

  def self.find_team_and_tackles(teams_by_id)
    team_and_total_tackles = {}
    teams_by_id.each do |team|
      goals_by_team = team[1].sum do |the_tackles|
        the_tackles.tackles
      end
      team_and_total_tackles[team[0]] = goals_by_team
    end
    team_and_total_tackles
  end

  def self.all_the_goals(teams_by_id)
    team_and_total_score = {}
    teams_by_id.each do |team|
      goals_by_team = []
      team[1].each do |the_game|
        goals_by_team << the_game.goals
      end
      total_by_team = goals_by_team.sum
      average_gpg = total_by_team.to_f / team[1].count
      team_and_total_score[team[0]] = average_gpg
    end
    team_and_total_score
  end

  def self.find_coach_name(best_or_worst_coach, game_teams)
    coach_name = []
    game_teams.each do |team|
      if team.team_id == best_or_worst_coach
        coach_name << team.head_coach
      end
    end
    coach_name
  end

  def select_season_games(season_id)
    season_games = @games
  end

  def self.find_head_coach_best_worst(games, game_teams, the_season, flag)
    coach_games_results = {}
    coach_games = {}
    coach_and_wins = []
    games_grouped_by_season = games.group_by do |game|
      game.season
    end
    season_games = games_grouped_by_season.map do |season, game_grouped_by_season|
      game_grouped_by_season.find_all do |season_game|
        season_game.season == the_season
      end
    end.flatten
    this_season_games = season_games.group_by do |season_game|
      season_game.season
    end
    season_games2 = this_season_games.map do |season, games|
       games.map do |x|
         x.game_id
       end
    end.flatten
    head_coaches_by_season_games = game_teams.each do |season_game|
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
    coach_games.each do |coach_name, game_results|
      coach_games_results[coach_name] = game_results
    end
    coach_games_results.each do |coach_name, game_results|
      game_results = game_results.split(",")
      coach_wins = game_results.find_all do |game_result|
        game_result == "WIN"
      end
      coach_and_wins << [coach_name , (2 * coach_wins.count) / (2 * game_results.count.to_f) * 100.round(2)]
    end
    coach_and_wins
  end

  # def self.find_team_name(team_id)
  #   team_name = @teams.find_all do |team|
  #     team.team_id
  #   end
  #   team_name[0].team_name
  #   binding.pry
  # end

  def self.find_team_name(team_id)
    team_name = []
    @teams.each do |team|
      if team.team_id == team_id[0].to_s
        team_name << team.team_name
      end
    end
    team_name[0]
  end


end
