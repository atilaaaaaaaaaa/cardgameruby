# Classe para refletir jogadores 1 e 2
class Jogador
  attr_accessor :mao, :nome, :vida

  QTD_VIDA = 20

  def initialize(nome)
    @nome = nome
    @mao = []
    @vida = QTD_VIDA
  end
end
