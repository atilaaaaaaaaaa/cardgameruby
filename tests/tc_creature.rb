require_relative '../card'
require_relative '../creature'
require_relative '../land'
require 'faker'
require 'test/unit'

class TestCreature < Test::Unit::TestCase

  def setup
    @@name_creature = Faker::Games::DnD.monster
    @@cost_creature = [1, 2, 3].sample
    @@power_creature = [0, 1, 2, 3, 4].sample
    @@toughness_creature = [1, 2, 3, 4, 5].sample
    @@creature = Creature.new(@@name_creature, @@cost_creature, @@power_creature, @@toughness_creature)
  end
  

  def test_initialize
    assert_equal(@@name_creature, @@creature.name)
    assert_equal(@@cost_creature, @@creature.cost)
    assert_equal(@@power_creature, @@creature.power)
    assert_equal(@@toughness_creature, @@creature.toughness)
    assert_equal(false, @@creature.blocking)
    assert_equal(@@toughness_creature, @@creature.life_pts)
    assert_equal(true, @@creature.sickness)
  end

  def test_sick
    @@creature.sickness = false
    assert_equal(false, @@creature.sick?)
  end

  def test_can_attack?
    creature = @@creature.dup
    creature.sickness = true
    creature.tap
    assert_equal(false, creature.can_attack?)
    creature.sickness = false
    creature.tapped = false
    assert_equal(true, creature.can_attack?)
  end

  def test_block_available?
    creature = @@creature.dup
    creature.blocking = true
    assert_equal(false, creature.block_available?)
  end
end