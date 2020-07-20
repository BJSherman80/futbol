require 'CSV'
require_relative './game_teams'
require_relative './game'
require_relative './team'

class SeasonStats

  attr_reader :game_teams,
              :teams,
              :games

  def initialize(filepath1, filepath2, filepath3)
    @game_teams = []
    @games      = []
    @teams      = []
    load_game_teams(filepath1)
    load_games(filepath2)
    load_teams(filepath3)
  end

  def load_game_teams(filepath1)
    CSV.foreach(filepath1, headers: true, header_converters: :symbol) do |data|
      @game_teams << GameTeams.new(data)
    end
  end

  def load_games(filepath2)
    CSV.foreach(filepath2, headers: true, header_converters: :symbol) do |data|
      @games << Game.new(data)
    end
  end

  def load_teams(filepath3)
    CSV.foreach(filepath3, headers: true, header_converters: :symbol) do |data|
      @teams << Team.new(data)
    end
  end

  def game_teams_find_by_game_id(game_id)
    @game_teams.find do |season_stat|
      season_stat.game_id == game_id
    end
  end

  def games_find_by_game_id(game_id)
    @games.find do |season_stat|
      season_stat.game_id == game_id
    end
  end

  def teams_find_by_team_id(team_id)
    @teams.find do |season_stat|
      season_stat.team_id == team_id
    end
  end

  def largest_hash_key(hash)
    hash.max_by{|k,v| v}
  end

  def smallest_hash_key(hash)
    hash.min_by{|k,v| v}
  end

  # #Name of the Coach with the best win percentage for the season	String
  #
  # def winningest_coach
  #
  # end
  #
  #
  # #Name of the Coach with the worst win percentage for the season	String
  # def worst_coach
  #
  # end
  #
  #
  # #Name of the Team with the best ratio of shots to goals for the season	String
  # def most_accurate_team
  #
  # end
  #
  #
  # #Name of the Team with the worst ratio of shots to goals for the season	String
  # def least_accurate_team
  #
  # end
  #
  #
  # #Name of the Team with the most tackles in the season	String
  # def most_tackles
  #
  # end
  #
  #
  # #Name of the Team with the fewest tackles in the season	String
  # def fewest_tackles
  #
  # end

end
