require_relative './helper_methods'
require 'pry'
class LeagueStats

  attr_reader :game_teams,
              :teams,
              :games

  def initialize(filepath1 = nil, filepath2 = nil, filepath3 = nil)

    @game_teams = HelperMethods.load_game_teams(filepath1)
    @games      = HelperMethods.load_games(filepath2)
    @teams      = HelperMethods.load_teams(filepath3)
  end

  # def load_game_teams(filepath1)
  #   CSV.foreach(filepath1, headers: true, header_converters: :symbol) do |data|
  #     @game_teams << GameTeams.new(data)
  #   end
  # end
  #
  # def load_games(filepath2)
  #   CSV.foreach(filepath2, headers: true, header_converters: :symbol) do |data|
  #     @games << Game.new(data)
  #   end
  # end
  #
  # def load_teams(filepath3)
  #   CSV.foreach(filepath3, headers: true, header_converters: :symbol) do |data|
  #     @teams << Team.new(data)
  #   end
  # end

    def best_offense
      teams_by_id = HelperMethods.find_teams_by_team_id(game_teams)
      team_and_total_score = HelperMethods.all_the_goals(teams_by_id)
      top_scorer = HelperMethods.largest_hash_value(team_and_total_score)
      best_team = HelperMethods.find_team_name(top_scorer)
      best_team
    end

    def worst_offense
      teams_by_id = HelperMethods.find_teams_by_team_id(game_teams)
      team_and_total_score = HelperMethods.all_the_goals(teams_by_id)
      bottom_scorer = HelperMethods.smallest_hash_value(team_and_total_score)
      worst_team = HelperMethods.find_team_name(bottom_scorer)
      worst_team
    end

    def highest_scoring_visitor
      away_games = HelperMethods.find_away_games(game_teams)
      teams_by_id = HelperMethods.find_teams_by_team_id(away_games)
      team_and_total_score = HelperMethods.all_the_goals(teams_by_id)
      top_scorer = HelperMethods.largest_hash_value(team_and_total_score)
      best_team = HelperMethods.find_team_name(top_scorer)
      best_team
    end

    def highest_scoring_home_team
      home_games = HelperMethods.find_home_games(game_teams)
      teams_by_id = HelperMethods.find_teams_by_team_id(home_games)
      team_and_total_score = HelperMethods.all_the_goals(teams_by_id)
      top_scorer = HelperMethods.largest_hash_value(team_and_total_score)
      best_team = HelperMethods.find_team_name(top_scorer)
      best_team
    end

    def lowest_scoring_visitor
      away_games = HelperMethods.find_away_games(game_teams)
      teams_by_id = HelperMethods.find_teams_by_team_id(away_games)
      team_and_total_score = HelperMethods.all_the_goals(teams_by_id)
      bottom_scorer = HelperMethods.smallest_hash_value(team_and_total_score)
      worst_team = HelperMethods.find_team_name(bottom_scorer)
      worst_team
    end

    def lowest_scoring_home_team
      home_games = HelperMethods.find_home_games(game_teams)
      teams_by_id = HelperMethods.find_teams_by_team_id(home_games)
      team_and_total_score = HelperMethods.all_the_goals(teams_by_id)
      bottom_scorer = HelperMethods.smallest_hash_value(team_and_total_score)
      worst_team = HelperMethods.find_team_name(bottom_scorer)
      worst_team
    end

    def count_of_teams
      @teams.map do |team|
        team.team_id
      end.count
    end
end
