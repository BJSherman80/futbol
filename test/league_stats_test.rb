require 'minitest/autorun'
require 'minitest/pride'
require './lib/league_stats'
class LeagueStatsTest < Minitest::Test
  def test_it_exists
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_instance_of LeagueStats, league_stats
  end
  def test_league_stats_has_league_stats_game_teams
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal 8, league_stats.game_teams.count
    assert_instance_of Array, league_stats.game_teams
    assert_equal "LOSS", league_stats.game_teams.first.result
  end
  def test_league_stats_has_league_stats_games
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal 7, league_stats.games.count
    assert_instance_of Array, league_stats.games
    assert_equal "/api/v1/venues/null", league_stats.games.first.venue_link
  end
  def test_league_stats_has_league_stats_teams
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal 8, league_stats.teams.count
    assert_instance_of Array, league_stats.teams
    assert_equal "Mercedes-Benz Stadium", league_stats.teams.first.stadium
  end
  def test_count_of_teams
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal 8, league_stats.count_of_teams
  end
  def test_best_offense
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal "FC Dallas", league_stats.best_offense
  end
  def test_worst_offense
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal "Orlando City SC", league_stats.worst_offense
  end
  def test_highest_scoring_visitor
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal "Houston Dynamo", league_stats.highest_scoring_visitor
  end
  def test_highest_scoring_home_team
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal "FC Dallas", league_stats.highest_scoring_home_team
  end
  def test_lowest_scoring_visitor
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal "Orlando City SC", league_stats.lowest_scoring_visitor
  end
  def test_lowest_scoring_home_team
    league_stats = LeagueStats.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    assert_equal "Houston Dynamo", league_stats.lowest_scoring_home_team
  end
  def test_count_of_teams
    league_stats = LeagueStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_equal 32, league_stats.count_of_teams
  end
  def test_best_offense
    league_stats = LeagueStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_equal "Reign FC", league_stats.best_offense
  end
  def test_worst_offense
    league_stats = LeagueStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_equal "Utah Royals FC", league_stats.worst_offense
  end
  def test_highest_scoring_visitor
    league_stats = LeagueStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_equal "FC Dallas", league_stats.highest_scoring_visitor
  end
  def test_highest_scoring_home_team
    league_stats = LeagueStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_equal "Reign FC", league_stats.highest_scoring_home_team
  end
  def test_lowest_scoring_visitor
    league_stats = LeagueStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_equal "San Jose Earthquakes", league_stats.lowest_scoring_visitor
  end
  def test_lowest_scoring_home_team
    league_stats = LeagueStats.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")
    assert_equal "Utah Royals FC", league_stats.lowest_scoring_home_team
  end
end
