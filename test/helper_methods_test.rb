
require 'minitest/autorun'
require 'minitest/pride'
require './lib/helper_methods'

class HelperMethodsTest < Minitest::Test

  def test_largest_hash_value
    hash = {9 => 999, 5 => 3}

    assert_equal [9, 999], HelperMethods.largest_hash_value(hash)
  end

  def test_smallest_hash_value
    hash = {9 => 999, 5 => 3}

    assert_equal [5, 3], HelperMethods.smallest_hash_value(hash)
  end

  def test_find_teams_by_team_id
    game_teams1 = GameTeams.new({:game_id => "2012030221", :team_id => "1", :hoa => "away", :result => "LOSS", :settled_in => "OT", :head_coach => "John Tortorella", :goals => "2", :shots => "8", :tackles => "44", :pim => "8", :powerplayopportunities => "3", :powerplaygoals => "0", :faceoffwinpercentage => "44.8", :giveaways => "17", :takeaways => "7"})
    game_teams2 = GameTeams.new({:game_id => "2013030176", :team_id => "25", :hoa => "home", :result => "WIN", :settled_in => "REG", :head_coach => "Lindy Ruff", :goals => "3", :shots => "6", :tackles => "40", :pim => "5", :powerplayopportunities => "1", :powerplaygoals => "8", :faceoffwinpercentage => "49.4", :giveaways => "13", :takeaways => "9"})

    game_teams = [game_teams1, game_teams2]

    assert_instance_of Hash, HelperMethods.find_teams_by_team_id(game_teams)
  end

  def test_find_team_name
    skip #potentially use Mock?
    team1 = Team.new({:team_id => "1", :franchiseid => "23", :teamname => "Atlanta United", :abbreviation => "ATL", :stadium => "Mercedes-Benz Stadium", :link => "/api/v1/teams/1"})
    team2 = Team.new({:team_id => "5", :franchiseid => "55", :teamname => "Denver United", :abbreviation => "DTL", :stadium => "Pepsi Center", :link => "/api/v1/teams/2"})
    teams = [team1, team2]
    assert_equal "Atlanta United", HelperMethods.find_team_name("1")[0]
  end


end
