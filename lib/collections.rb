require 'CSV'
require_relative './game_teams'
require_relative './game'
require_relative './team'
require 'pry'

class Collections
  attr_reader :games,
              :game_teams,
              :teams

  def initialize(filepath1, filepath2, filepath3)
    load_games(filepath1)
    load_teams(filepath2)
    load_game_teams(filepath3)
  end

  def load_games(filepath1)
    @games = []
    CSV.foreach(filepath1, headers: true, header_converters: :symbol) do |data|
      @games << Game.new(data)
    end
  end

  def load_teams(filepath2)
    @teams = []
    CSV.foreach(filepath2, headers: true, header_converters: :symbol) do |data|
      @teams << Team.new(data)
    end
  end

  def load_game_teams(filepath3)
    @game_teams = []
    CSV.foreach(filepath3, headers: true, header_converters: :symbol) do |data|
      @game_teams << GameTeams.new(data)
    end
  end





end
