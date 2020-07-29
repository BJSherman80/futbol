require_relative './helper_methods'
require_relative 'collections'
class LeagueStats < Collections
   def initialize(game_path, team_path, game_teams_path)
    # @@game_teams = HelperMethods.load_@game_teams(filepath1)
    # @games      = HelperMethods.load_games(filepath2)
    # @teams      = HelperMethods.load_teams(filepath3)
    @teams = super
     @games = super
     @game_teams = super
  end


  def find_away_games
    @game_teams.find_all do |game_team|
      game_team.hoa == "away"
    end
  end

  def find_home_games
    @game_teams.find_all do |game_team|
      game_team.hoa == "home"
    end
  end

  def all_the_goals(teams_by_id)
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

  def count_of_teams
    @teams.map do |team|
      team.team_id
    end.count
  end

  def find_teams_by_team_id(game_teams)
    @game_teams.group_by do |game_team|
      game_team.team_id
    end
  end

  def best_offense
    teams_by_id = find_teams_by_team_id(@game_teams)
    team_and_total_score = all_the_goals(teams_by_id)
    top_scorer = HelperMethods.largest_hash_value(team_and_total_score)
    best_team = HelperMethods.find_team_name(top_scorer)
    best_team[0]
  end

  def worst_offense
    teams_by_id = HelperMethods.find_teams_by_team_id(@game_teams)
    team_and_total_score = all_the_goals(teams_by_id)
    bottom_scorer = HelperMethods.smallest_hash_value(team_and_total_score)
    worst_team = HelperMethods.find_team_name(bottom_scorer)
    worst_team[0]
  end

  def highest_scoring_visitor
    away_games = find_away_games
    teams_by_id = HelperMethods.find_teams_by_team_id(away_games)
    team_and_total_score = all_the_goals(teams_by_id)
    top_scorer = HelperMethods.largest_hash_value(team_and_total_score)
    best_team = HelperMethods.find_team_name(top_scorer)
    best_team[0]
  end

  def highest_scoring_home_team
    home_games = find_home_games
    teams_by_id = HelperMethods.find_teams_by_team_id(home_games)
    team_and_total_score = all_the_goals(teams_by_id)
    top_scorer = HelperMethods.largest_hash_value(team_and_total_score)
    best_team = HelperMethods.find_team_name(top_scorer)
    best_team[0]
  end

  def lowest_scoring_visitor
    away_games = find_away_games
    teams_by_id = HelperMethods.find_teams_by_team_id(away_games)
    team_and_total_score = all_the_goals(teams_by_id)
    bottom_scorer = HelperMethods.smallest_hash_value(team_and_total_score)
    worst_team = HelperMethods.find_team_name(bottom_scorer)
    worst_team[0]
  end

  def lowest_scoring_home_team
    home_games = find_home_games
    teams_by_id = HelperMethods.find_teams_by_team_id(home_games)
    team_and_total_score = all_the_goals(teams_by_id)
    bottom_scorer = HelperMethods.smallest_hash_value(team_and_total_score)
    worst_team = HelperMethods.find_team_name(bottom_scorer)
    worst_team[0]
  end

end
