require 'grimorio'
# Classe para refletir jogadores 1 e 2
class Jogador
  attr_accessor :mao, :nome, :vida, :grimorio

  QTD_VIDA = 20

  def initialize(nome)
    @nome = nome
    @mao = []
    @vida = QTD_VIDA
    @grimorio = Grimorio.new
  end
end