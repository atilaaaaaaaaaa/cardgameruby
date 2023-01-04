require 'carta'

#Tipo de carta que reflete a mana
class Terreno < Carta
  def initialize(nome)
    super(nome, 0)
  end

end