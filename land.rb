require_relative 'card'

# Tipo de carta que reflete a mana
class Land < Card
  def initialize(name)
    super(name, 0)
  end

end