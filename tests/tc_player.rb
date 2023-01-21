require_relative '../card'
require_relative '../library'
require_relative '../creature'
require_relative '../land'
require_relative '../player'
require 'faker'
require 'test/unit'

class TestPlayer < Test::Unit::TestCase

  def setup
    @@name = Faker::Games::HalfLife::character
    @@player = Player.new(@@name)
  end

  def test_initialize
    assert_equal(@@name, @@player.name)
    assert_equal(0, @@player.hand.size)
    assert_equal(Player::LIFE_PTS, @@player.life)
    assert_instance_of(Library, @@player.library)
    assert_equal(false, @@player.turn)
    assert_equal(0, @@player.played_cards.size)
  end

  def test_untap_cards
    @@player.played_cards.push(Card.new('card', 2))
    @@player.played_cards.push(Land.new('land'))
    @@player.played_cards.push(Creature.new('creature', 3, 2, 2))
    @@player.untap_cards
    @@player.played_cards.map { |card| card.tapped? }.all?
  end

  def test_played_lands
    @@player.played_cards.push(Land.new('land 2'))
    assert_equal(1, @@player.played_lands.size)
  end

  def test_summoned_creatures
    @@player.played_cards.push(Creature.new('creature 2', 3, 2, 2))
    assert_equal(1, @@player.summoned_creatures.size)
  end

  def test_played_untapped_lands
    @@player.played_cards.push(Land.new('land 3'))
    @@player.played_cards.first.tap
    @@player.played_cards.push(Land.new('land 4'))
    assert_not_equal(2, @@player.played_untapped_lands.size)
  end

end