require_relative 'card'

# Tipo de carta que reflete criaturas para batalhar
class Creature < Card
  attr_reader :power, :keyword

  attr_accessor :toughness, :blocking, :life_pts, :sickness

  def initialize(name, cost, power, toughness, keyword = nil)
    super(name, cost)
    @power = power
    @toughness = toughness
    @keyword = keyword
    @blocking = false
    @life_pts = @toughness
    @sickness = true
  end

  def sick?
    @sickness == true
  end

  def can_attack?
    # binding.break
    untapped? && !sick?
  end

  def block_available?
    @blocking == false
  end
end