require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_teams'
class GameTeamsTest < Minitest::Test
  def test_it_exists
    game_teams1 = GameTeams.new({:game_id => "2012030221", :team_id => "1", :HoA => "away", :result => "LOSS", :settled_in => "OT", :head_coach => "John Tortorella", :goals => "2", :shots => "8", :tackles => "44", :pim => "8", :powerplayopportunities => "3", :powerplaygoals => "0", :faceoffwinpercentage => "44.8", :giveaways => "17", :takeaways => "7"})
    assert_instance_of GameTeams, game_teams1
  end
  def test_it_has_attributes
    game_teams1 = GameTeams.new({:game_id => "2012030221", :team_id => "1", :hoa => "away", :result => "LOSS", :settled_in => "OT", :head_coach => "John Tortorella", :goals => "2", :shots => "8", :tackles => "44", :pim => "8", :powerplayopportunities => "3", :powerplaygoals => "0", :faceoffwinpercentage => "44.8", :giveaways => "17", :takeaways => "7"})
    assert_equal 2012030221, game_teams1.game_id
    assert_equal 1, game_teams1.team_id
    assert_equal "away", game_teams1.hoa
    assert_equal "LOSS", game_teams1.result
    assert_equal "OT", game_teams1.settled_in
    assert_equal "John Tortorella", game_teams1.head_coach
    assert_equal 2, game_teams1.goals
    assert_equal 8, game_teams1.shots
    assert_equal 44, game_teams1.tackles
    assert_equal 8, game_teams1.pim
    assert_equal 3, game_teams1.powerplayopportunities
    assert_equal 0, game_teams1.powerplaygoals
    assert_equal 44.8, game_teams1.faceoffwinpercentage
    assert_equal 17, game_teams1.giveaways
    assert_equal 7, game_teams1.takeaways
  end
  def test_it_has_different_attributes
    game_teams1 = GameTeams.new({:game_id => "2013030176", :team_id => "25", :hoa => "home", :result => "WIN", :settled_in => "REG", :head_coach => "Lindy Ruff", :goals => "3", :shots => "6", :tackles => "40", :pim => "5", :powerplayopportunities => "1", :powerplaygoals => "8", :faceoffwinpercentage => "49.4", :giveaways => "13", :takeaways => "9"})
    assert_equal 2013030176, game_teams1.game_id
    assert_equal 25, game_teams1.team_id
    assert_equal "home", game_teams1.hoa
    assert_equal "WIN", game_teams1.result
    assert_equal "REG", game_teams1.settled_in
    assert_equal "Lindy Ruff", game_teams1.head_coach
    assert_equal 3, game_teams1.goals
    assert_equal 6, game_teams1.shots
    assert_equal 40, game_teams1.tackles
    assert_equal 5, game_teams1.pim
    assert_equal 1, game_teams1.powerplayopportunities
    assert_equal 8, game_teams1.powerplaygoals
    assert_equal 49.4, game_teams1.faceoffwinpercentage
    assert_equal 13, game_teams1.giveaways
    assert_equal 9, game_teams1.takeaways
  end
end
