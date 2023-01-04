require 'carta'

# Tipo de carta que reflete criaturas para batalhar
class Monstro < Carta
  attr_reader :ataque, :defesa, :habilidade

  def initialize(nome, custo, ataque, defesa, habilidade = nil)
    super(nome, custo)
    @ataque = ataque
    @defesa = defesa
    @habilidade = habilidade
  end
end