require_relative '../card'
require_relative '../creature'
require_relative '../land'
require 'faker'
require 'test/unit'

class TestLand < Test::Unit::TestCase

  def test_initialize
    name_land = %w[Swamp Plains Island Mountain Forest].sample
    land = Land.new(name_land)
    assert_equal(name_land, land.name)

  end

end