# Responsável pelas cartas do jogo
class Carta
  attr_reader :nome, :custo
  attr_accessor :virada

  def initialize(nome, custo)
    @nome = nome
    @custo = custo
    @virada = false
  end

  def monstro?
    is_a?(Monstro)
  end

  def terreno?
    is_a?(Terreno)
  end

  def virar
    @virada = true
  end

  def virada?
    @virada
  end

  def desvirada?
    !@virada
  end

end
