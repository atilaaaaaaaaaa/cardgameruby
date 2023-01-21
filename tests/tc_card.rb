require_relative '../card'
require_relative '../library'
require_relative '../creature'
require_relative '../land'
require 'faker'
require 'test/unit'

class TestCard < Test::Unit::TestCase

  def setup
    @@name_land = %w[Swamp Plains Island Mountain Forest].sample
    @@land = Land.new(@@name_land)
    @@name_creature = Faker::Games::DnD.monster
    @@cost_creature = [1, 2, 3].sample
    @@power_creature = [0, 1, 2, 3, 4].sample
    @@toughness_creature = [1, 2, 3, 4, 5].sample
    @@creature = Creature.new(@@name_creature, @@cost_creature, @@power_creature, @@toughness_creature)
    @@name_card = Faker::Games::DnD.monster
    @@cost_card = [1, 2, 3].sample
    @@card = Card.new(@@name_card, @@cost_card)
  end

  def test_initialize
    assert_equal(@@name_card, @@card.name)
    assert_equal(@@cost_card, @@card.cost)
  end

  def test_creature?
    assert_equal(true, @@creature.creature?)
    assert_equal(false, @@land.creature?)
  end

  def test_land?
    assert_equal(true, @@land.land?)
    assert_equal(false, @@creature.land?)
  end

  def test_tap
    assert_equal(false, @@card.tapped)
    @@card.tap
    assert_equal(true, @@card.tapped)
  end

  def test_tapped?
    @@card.tapped = false
    assert_equal(false, @@card.tapped?)
  end

  def test_untapped?
    assert_equal(true, @@card.untapped?)
  end

end