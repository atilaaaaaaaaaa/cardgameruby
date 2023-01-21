class Rules

  def self.insufficient_mana(card, current_player)
  return 'Insufficient ana' if card.cost > current_player.played_lands.size

  nil
  end
end