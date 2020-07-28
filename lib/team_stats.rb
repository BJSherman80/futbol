require_relative './helper_methods'
# require 'CSV'
# require_relative './game'
# require_relative './team'
# require_relative './game_teams'
# require_relative './helper_methods'
# require 'pry'

class TeamStats
  attr_reader :game_teams,
              :teams,
              :games

  def initialize(filepath1, filepath2, filepath3)

    @game_teams = HelperMethods.load_game_teams(filepath1)
    @games      = HelperMethods.load_games(filepath2)
    @teams      = HelperMethods.load_teams(filepath3)
  end

  def team_info(team_id)

    hash = {}
    information = @teams.find { |team| team.team_id == team_id }
    hash["team_id"]= information.team_id
    hash["franchise_id"]= information.franchise_id
    hash["team_name"]= information.team_name
    hash["abbreviation"]= information.abbreviation
    hash["link"]= information.link
    hash
  end

  def find_games_by_team_id(team_id)
    @stat_tracker.find_games_by_team_id(team_id)
  end

  def largest_hash_value(hash)
    hash.max_by{|k,v| v}
  end

  def smallest_hash_value(hash)
    hash.min_by{|k,v| v}
  end

  def find_team_name(best_or_worst_team)
    team_name = []
    teams.each do |team|
      if team.team_id == best_or_worst_team.to_s
        team_name << team.team_name
      end
    end
    team_name
  end

  def games_by_team_id

  end

  def games_by_team_id(team_id)
    @games_by_team_id_array = []
    @games.each do |game|
      if game.away_team_id == (team_id) || game.home_team_id == (team_id)
        @games_by_team_id_array << game
      end
    end
    @games_by_team_id_array
  end

  def games_by_season
    @seasons_hash = @games_by_team_id_array.group_by do |game|
      game.season
    end
    @seasons_hash
  end

  def games_by_season_count
    @games_by_season_count = {}
    @seasons_hash.each do |season, season_games|
      @games_by_season_count[season] = (season_games.count)
    end
    @games_by_season_count
  end

  def wins_by_season
    @season_wins = @wins.group_by {|game| game.season}
  end

  def wins_by_season_count
    @season_wins_count = {}
    @season_wins.each do |season, season_games|
      @season_wins_count[season] = (season_games.count)
    end
    @season_wins_count
  end

  def wins_across_all_seasons(team_id)
    @wins = []
    @seasons_hash.each do |season|
      season[1].each do |game|
      if (team_id == game.away_team_id) && (game.away_goals > game.home_goals) == true
        @wins << game
      elsif (team_id == game.home_team_id) && (game.away_goals < game.home_goals) == true
        @wins << game
      end
    end
  end
  @wins.count
  end

  def best_season(team_id)
    season_by_win_percentage = {}
    games_by_team_id(team_id)
    games_by_season
    wins_across_all_seasons(team_id)
    wins_by_season
    wins_by_season_count
    games_by_season_count

    wins_by_season_count.each do |win_by_season_count|
      games_by_season_count.each do |game_by_season_count|
        if game_by_season_count[0] == win_by_season_count[0]
          season_by_win_percentage[win_by_season_count[0]]= win_by_season_count[1].to_f / game_by_season_count[1].to_f
        end
      end
    end
    the_best_season = HelperMethods.largest_hash_value(season_by_win_percentage)
    the_best_season[0].to_s
  end

  def worst_season(team_id)
    season_by_win_percentage = {}
    games_by_team_id(team_id)
    games_by_season
    wins_across_all_seasons(team_id)
    wins_by_season
    wins_by_season_count
    games_by_season_count

    wins_by_season_count.each do |win_by_season_count|
      games_by_season_count.each do |game_by_season_count|
        if game_by_season_count[0] == win_by_season_count[0]
          season_by_win_percentage[win_by_season_count[0]]= win_by_season_count[1].to_f / game_by_season_count[1].to_f
        end
      end
    end
    the_worst_season = HelperMethods.smallest_hash_value(season_by_win_percentage)
    the_worst_season[0].to_s
  end

  def average_win_percentage(team_id)
    games_by_team_id(team_id)
    games_by_season
    @wins = []
    @team_games = []
    @seasons_hash.each do |season|
      season[1].each do |game|
        if (team_id == game.away_team_id) && (game.away_goals > game.home_goals) == true
          @wins << game
        elsif (team_id == game.home_team_id) && (game.away_goals < game.home_goals) == true
          @wins << game
        end
      end
    end
    @seasons_hash.each do |season1|
      season1[1].each do |game|
        if (team_id == game.away_team_id) == true
          @team_games << game
        elsif (team_id == game.home_team_id) == true
          @team_games << game
        end
      end
    end
  total_wins = (@wins.count.to_f / @team_games.count.to_f).round(2)

    total_wins
  end

  def most_goals_scored(team_id)
    @away_goals = []
    @home_goals = []
      @games.each do |game|
        if (team_id == game.away_team_id)
          @away_goals << game.away_goals
        elsif (team_id == game.home_team_id)
          @home_goals << game.home_goals
        end
      end
    @away_goals.concat(@home_goals).max.to_i
  end

  def fewest_goals_scored(team_id)
    @away_goals = []
    @home_goals = []
      @games.each do |game|
        if (team_id == game.away_team_id)
          @away_goals << game.away_goals
        elsif (team_id == game.home_team_id)
          @home_goals << game.home_goals
        end
      end
    @away_goals.concat(@home_goals).min.to_i
  end


  def favorite_opponent(team_id)
    other_teams_by_game = {}
    other_teams_by_win_percentage = {}
    home_games = []
    away_games = []
    @games.find_all do |game|
      if game.away_team_id == team_id
        away_games << game
      elsif game.home_team_id == team_id
        home_games << game
      end
    end
    home_teams_by_game = away_games.group_by do |away_game|
      away_game.home_team_id
    end
    away_teams_by_game = home_games.group_by do |home_game|
      home_game.away_team_id
    end
    other_teams_by_game = home_teams_by_game.merge(away_teams_by_game)
    other_teams_by_game.each do |other_team_by_game|
      wins = []
      ties = []
      other_team_by_game[1].each do |game|
        if (team_id == game.away_team_id) && (game.away_goals < game.home_goals)
          wins << game
        elsif (team_id == game.home_team_id) && (game.away_goals > game.home_goals)
          wins << game
        elsif (team_id == game.away_team_id) && (game.away_goals == game.home_goals)
          ties << game
        elsif (team_id == game.home_team_id) && (game.away_goals == game.home_goals)
          ties << game
        else
          next
        end
      end
      total_wins = (((2 * wins.count.to_f) + ties.count.to_f) / (2 * other_team_by_game[1].count.to_f)).round(2)
      other_teams_by_win_percentage[other_team_by_game[0]] = total_wins
    end
    favorite_opponent_team_id = smallest_hash_value(other_teams_by_win_percentage)
    favorite_opponent = find_team_name(favorite_opponent_team_id[0])
    favorite_opponent[0]
  end

  def rival(team_id)
    other_teams_by_game = {}
    other_teams_by_win_percentage = {}
    home_games = []
    away_games = []
    @games.find_all do |game|
      if game.away_team_id == team_id
        away_games << game
      elsif game.home_team_id == team_id
        home_games << game
      end
    end
    home_teams_by_game = away_games.group_by do |away_game|
      away_game.home_team_id
    end
    away_teams_by_game = home_games.group_by do |home_game|
      home_game.away_team_id
    end
    other_teams_by_game = home_teams_by_game.merge(away_teams_by_game)
    other_teams_by_game.each do |other_team_by_game|
      our_games = []
      wins = []
      ties = []
      other_team_by_game[1].each do |game|
        if (team_id == game.away_team_id) && (game.away_goals < game.home_goals)
          wins << game
        elsif (team_id == game.home_team_id) && (game.away_goals > game.home_goals)
          wins << game
        elsif (team_id == game.away_team_id) && (game.away_goals == game.home_goals)
          ties << game
        elsif (team_id == game.home_team_id) && (game.away_goals == game.home_goals)
          ties << game
        else
          next
        end
      end
      other_team_by_game[1].each do |game1|
        if team_id == game1.away_team_id
          our_games << game1
        elsif team_id == game1.home_team_id
          our_games << game1
        end
      end
      total_wins = ((wins.count.to_f / our_games.count.to_f) * 100).round(2)
      other_teams_by_win_percentage[other_team_by_game[0]] = total_wins
    end
    rival_team_id = largest_hash_value(other_teams_by_win_percentage)
    rival = find_team_name(rival_team_id[0])
    rival[0]
  end
end
