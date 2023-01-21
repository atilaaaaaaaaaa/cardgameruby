require_relative 'library'
# Classe para refletir jogadores 1 e 2
class Player
  attr_accessor :hand, :name, :life, :library, :turn, :played_cards

  LIFE_PTS = 20

  def initialize(name)
    @name = name
    @hand = []
    @life = LIFE_PTS
    @library = Library.new
    @turn = false
    @played_cards = []
  end

  def untap_cards
    played_cards.each do |card|
      card.tapped = false
    end
  end

  def played_lands
    played_cards.map { |card| card if card.is_a?(Land) }.compact
  end

  def played_untapped_lands
    played_lands.select { |land| land.untapped? }
  end

  def summoned_creatures
    played_cards.map { |card| card if card.is_a?(Creature) }.compact
  end
end
