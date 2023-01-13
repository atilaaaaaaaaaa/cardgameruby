require 'grimorio'
# Classe para refletir jogadores 1 e 2
class Jogador
  attr_accessor :mao, :nome, :vida, :grimorio, :turno, :cartas_baixadas

  QTD_VIDA = 20

  def initialize(nome)
    @nome = nome
    @mao = []
    @vida = QTD_VIDA
    @grimorio = Grimorio.new
    @turno = false
    @cartas_baixadas = []
  end

  def terrenos_baixados
    cartas_baixadas.map { |carta| carta if carta.is_a?(Terreno) }.compact
  end

  def criaturas_baixadas
    cartas_baixadas.map { |carta| carta if carta.is_a?(Monstro) }.compact
  end
end
