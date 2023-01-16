require 'carta'

# Tipo de carta que reflete criaturas para batalhar
class Monstro < Carta
  attr_reader :ataque, :habilidade

  attr_accessor :defesa, :defendendo, :pts_vida, :enjoo

  def initialize(nome, custo, ataque, defesa, habilidade = nil)
    super(nome, custo)
    @ataque = ataque
    @defesa = defesa
    @habilidade = habilidade
    @defendendo = false
    @pts_vida = @defesa
    @enjoo = true
  end

  def enjoada?
    @enjoo == true
  end

  def pode_atacar?
    # binding.break
    desvirada? && !enjoada?
  end

  def defesa_disponivel?
    @defendendo == false
  end
end