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
  def winningest_coach(the_season)
    HelperMethods.find_head_coach_best_worst(@games, @game_teams, the_season, "WIN").max_by {|x| x[1]}[0]
  end
  def worst_coach(the_season)
    HelperMethods.find_head_coach_best_worst(@games, @game_teams, the_season, "WIN").min_by {|x| x[1]}[0]
  end
  def most_accurate_team(the_season)
    game_teams_by_id = HelperMethods.find_teams_by_game_id(game_teams)
    this_season = HelperMethods.find_this_season(the_season)
    this_season_game_ids = @stat_tracker.find_games_by_game_id(this_season)
    game_list = HelperMethods.find_game_list(game_teams_by_id, this_season_game_ids)
    teams_by_id = HelperMethods.find_teams_by_team_id(game_list)
    team_and_accuracy = HelperMethods.find_team_and_accuracy(teams_by_id)
    best_team = HelperMethods.largest_hash_value(team_and_accuracy)
    team_name = HelperMethods.find_team_name(best_team)
    team_name
  end
  def least_accurate_team(the_season)
    game_teams_by_id = HelperMethods.find_teams_by_game_id(game_teams)
    this_season = HelperMethods.find_this_season(the_season)
    this_season_game_ids = HelperMethods.find_games_by_game_id(this_season)
    game_list = HelperMethods.find_game_list(game_teams_by_id, this_season_game_ids)
    teams_by_id = HelperMethods.find_teams_by_team_id(game_list)
    team_and_accuracy = HelperMethods.find_team_and_accuracy(teams_by_id)
    worst_team = HelperMethods.smallest_hash_value(team_and_accuracy)
    team_name = HelperMethods.find_team_name(worst_team)
    team_name
  end
  def most_tackles(the_season)
    this_season = HelperMethods.find_this_season(the_season)
    game_teams_by_id = HelperMethods.find_teams_by_game_id(game_teams)
    this_season_game_ids = HelperMethods.find_games_by_game_id(this_season)
    game_list = HelperMethods.find_game_list(game_teams_by_id, this_season_game_ids)
    teams_by_id = HelperMethods.find_teams_by_team_id(game_list)
    team_and_total_tackles = HelperMethods.find_team_and_tackles(teams_by_id)
    top_tacklers = HelperMethods.largest_hash_value(team_and_total_tackles)
    highest_tacklers = HelperMethods.find_team_name(top_tacklers)
    highest_tacklers
  end
  def fewest_tackles(the_season)
    this_season = HelperMethods.find_this_season(the_season)
    game_teams_by_id = HelperMethods.find_teams_by_game_id(game_teams)
    this_season_game_ids = HelperMethods.find_games_by_game_id(this_season)
    game_list = HelperMethods.find_game_list(game_teams_by_id, this_season_game_ids)
    teams_by_id = HelperMethods.find_teams_by_team_id(game_list)
    team_and_total_tackles = HelperMethods.find_team_and_tackles(teams_by_id)
    bottom_tacklers = HelperMethods.smallest_hash_value(team_and_total_tackles)
    lowest_tacklers = HelperMethods.find_team_name(bottom_tacklers)
    lowest_tacklers
  end
end
