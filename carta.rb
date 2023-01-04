# Responsável pelas cartas do jogo
class Carta
  attr_reader :nome, :custo

  def initialize(nome, custo)
    @nome = nome
    @custo = custo
  end
end
