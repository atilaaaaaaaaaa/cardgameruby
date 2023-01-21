# Responsável pelas cartas do jogo
class Card
  attr_reader :name, :cost
  attr_accessor :tapped

  def initialize(name, cost)
    @name = name
    @cost = cost
    @tapped = false
  end

  def creature?
    is_a?(Creature)
  end

  def land?
    is_a?(Land)
  end

  def tap
    @tapped = true
  end

  def tapped?
    @tapped
  end

  def untapped?
    !@tapped
  end

end
