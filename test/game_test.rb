require 'minitest/autorun'
require './lib/game.rb'
require 'minitest/pride'
class GameTest < Minitest::Test
  def test_it_exists
    game = Game.new({ :game_id => "17",
                      :season => "6",
                      :type => "Regular Season",
                      :date_time => "7/19/2020",
                      :away_team_id => "5",
                      :home_team_id => "2",
                      :away_goals => "3",
                      :home_goals => "4",
                      :venue => "Phil's House",
                      :venue_link => "null" })
    assert_instance_of Game, game
  end
  def test_it_has_attributes
    game = Game.new({:game_id => "17", :season => "6",
       :type => "Regular Season", :date_time => "7/19/2020",
        :away_team_id => "5", :home_team_id => "2", :away_goals => "3",
         :home_goals => "4", :venue => "Phil's House",
          :venue_link => "null" })
    assert_equal "17", game.game_id
    assert_equal "6", game.season
    assert_equal "Regular Season", game.type
    assert_equal "7/19/2020", game.date_time
    assert_equal "5", game.away_team_id
    assert_equal "2", game.home_team_id
    assert_equal "3", game.away_goals
    assert_equal "4", game.home_goals
    assert_equal "Phil's House", game.venue
    assert_equal "null", game.venue_link
  end
  def test_it_can_have_different_attributes
    game2 = Game.new({:game_id => "18", :season => "7",
       :type => "PostSeason", :date_time => "7/20/2020",
        :away_team_id => "6", :home_team_id => "3", :away_goals => "4",
         :home_goals => "5", :venue => "Sean's House",
          :venue_link => "null" })
    assert_equal "18", game2.game_id
    assert_equal "7", game2.season
    assert_equal "PostSeason", game2.type
    assert_equal "7/20/2020", game2.date_time
    assert_equal "6", game2.away_team_id
    assert_equal "3", game2.home_team_id
    assert_equal "4", game2.away_goals
    assert_equal "5", game2.home_goals
    assert_equal "Sean's House", game2.venue
    assert_equal "null", game2.venue_link
  end
  def test_it_can_give_total_goals
    game1 = Game.new({away_goals: "4", home_goals: "5"})
    game2 = Game.new({away_goals: "2", home_goals: "3"})
    game3 = Game.new({away_goals: "1", home_goals: "2"})
    assert_equal "9", game1.total_goals_for_game
    assert_equal "5", game2.total_goals_for_game
    assert_equal "3", game3.total_goals_for_game
  end
end
