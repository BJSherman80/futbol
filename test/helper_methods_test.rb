
require 'minitest/autorun'
require 'minitest/pride'
require './lib/helper_methods'
require 'pry'

class HelperMethodsTest < Minitest::Test

  def test_season_stats_has_season_stats_game_teams
    season_stats = HelperMethods.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_equal 14882, season_stats.game_teams.count
    assert_instance_of Array, season_stats.game_teams
    assert_equal "LOSS", season_stats.game_teams.first.result
  end

  def test_season_stats_has_season_stats_games
    season_stats = HelperMethods.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_equal 7441, season_stats.games.count
    assert_instance_of Array, season_stats.games
    assert_equal "/api/v1/venues/null", season_stats.games.first.venue_link
  end

  def test_season_stats_has_season_stats_teams
    season_stats = HelperMethods.new("./data/game_teams.csv", "./data/games.csv", "./data/teams.csv")

    assert_equal 32, season_stats.teams.count
    assert_instance_of Array, season_stats.teams
    assert_equal "Mercedes-Benz Stadium", season_stats.teams.first.stadium
  end

  # HELPER METHODS

  def test_largest_hash_value
    season_stats = HelperMethods.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    hash = {9 => 999, 5 => 3}

    assert_equal [9, 999], season_stats.largest_hash_value(hash)
  end

  def test_smallest_hash_value
    season_stats = HelperMethods.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
    hash = {9 => 999, 5 => 3}

    assert_equal [5, 3], season_stats.smallest_hash_value(hash)
  end

  def test_find_this_season
    season_stats = HelperMethods.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")

    assert_equal 5, season_stats.find_this_season(20122013).count
  end

  # def test_find_teams_by_team_id
  #   season_stats = HelperMethods.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
  #
  #   # binding.pry
  #   assert_equal 4, find_teams_by_team_id(season_stats.game_teams.count)
  # end
  #
  # def test_find_teams_by_game_id
  #   season_stats = HelperMethods.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
  #
  #   assert_equal 5, find_teams_by_game_id(season_stats.game_teams.count)
  # end

  #   def test_find_game_list
  #     season_stats = HelperMethods.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
  # # binding.pry
  #     games_by_game_id = get_teams_by_game_id(season_stats.game_teams)
  #     this_season = find_this_season(20122013)
  #     games_with_key_as_game_id = find_games_by_game_id(this_season)
  #
  #     assert_equal 1, season_stats.find_game_list(games_with_key_as_game_id, games_by_game_id).count
  #   end
  #
  # def test_find_game_list_with_reduce
  #   season_stats = HelperMethods.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
  #
  #   assert_equal nil, season_stats.find_game_list_with_reduce(games_with_key_as_game_id, games_by_game_id)
  # end

  # def test_get_teams_by_team_id
  #   season_stats = HelperMethods.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
  #
  #   assert_equal 4, season_stats.get_teams_by_team_id(season_stats.game_teams).count
  # end
  #
  # def test_get_teams_by_game_id
  #   season_stats = HelperMethods.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
  #
  #   assert_equal 5, season_stats.get_teams_by_game_id(season_stats.game_teams).count
  # end

  # def test_find_team_and_accuracy
  #   season_stats = HelperMethods.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
  #
  #   teams_by_id = get_teams_by_team_id(season_stats.game_teams)
  #
  #   assert_equal nil, season_stats.find_team_and_accuracy(teams_by_id)
  # end

  # def test_find_team_name
  #   season_stats = HelperMethods.new("./test/luke_fixtures/fixtures_game_teams.csv", "./test/luke_fixtures/fixtures_games.csv", "./test/luke_fixtures/fixtures_teams.csv")
  #
  #   teams_by_id = get_teams_by_team_id(season_stats.game_teams)
  #   team_and_accuracy = find_team_and_accuracy(teams_by_id)
  #   best_team = largest_hash_value(team_and_accuracy)[0]
  #   team_name = find_team_name(best_team)
  #
  #   assert_equal nil, season_stats.find_team_name(team_name)
  # end
end
