require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
class TeamTest < Minitest::Test
  def test_it_exists
    team1 = Team.new({:team_id => "1", :franchiseId => "23", :teamName => "Atlanta United", :abbreviation => "ATL", :stadium => "Mercedes-Benz Stadium", :link => "/api/v1/teams/1"})
    assert_instance_of Team, team1
  end
  def test_it_has_attributes
    team1 = Team.new({:team_id => "1", :franchiseid => "23", :teamname => "Atlanta United", :abbreviation => "ATL", :stadium => "Mercedes-Benz Stadium", :link => "/api/v1/teams/1"})
    assert_equal "1", team1.team_id
    assert_equal "23", team1.franchise_id
    assert_equal "Atlanta United", team1.team_name
    assert_equal "ATL", team1.abbreviation
    assert_equal "Mercedes-Benz Stadium", team1.stadium
    assert_equal "/api/v1/teams/1", team1.link
  end
  def test_it_has_different_attributes
    team1 = Team.new({:team_id => "1", :franchiseid => "55", :teamname => "Denver United", :abbreviation => "DTL", :stadium => "Pepsi Center", :link => "/api/v1/teams/2"})
    assert_equal "1", team1.team_id
    assert_equal "55", team1.franchise_id
    assert_equal "Denver United", team1.team_name
    assert_equal "DTL", team1.abbreviation
    assert_equal "Pepsi Center", team1.stadium
    assert_equal "/api/v1/teams/2", team1.link
  end
end
