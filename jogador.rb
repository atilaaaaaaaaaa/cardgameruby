# Classe para refletir jogadores 1 e 2
class Jogador
  attr_accessor :mao

  def initialize(nome)
    @nome = nome
    @mao = []
  end
end
