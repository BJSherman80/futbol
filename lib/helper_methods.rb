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

  def self.largest_hash_value(hash)
    hash.max_by{|key, value| value}
  end

  def self.smallest_hash_value(hash)
    hash.min_by{|key, value| value}
  end

  def self.find_teams_by_team_id(game_teams)
    game_teams.group_by do |game_team|
      game_team.team_id
    end
  end

  def self.find_team_name(team_id)
    team_name = []
    @teams.each do |team|
      if team.team_id == team_id[0].to_s
        team_name << team.team_name
      end
    end
    team_name
  end
end
