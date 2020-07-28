require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
class StatTrackerTest < Minitest::Test
  def test_it_exists
    stat_tracker = StatTrackerTest.new("locations")
    assert_instance_of StatTrackerTest, stat_tracker
  end
end
