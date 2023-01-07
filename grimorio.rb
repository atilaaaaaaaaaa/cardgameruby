# Classe que reflete deck de cartas dos jogadores
class Grimorio
  attr_accessor :todos, :monstros, :terrenos

  QTD_DECK = 60

  def initialize
    @monstros = []
    @terrenos = []
    @todos = []
    preparar_grimorio
  end

  def preparar_grimorio
    until @monstros.size == (QTD_DECK - (QTD_DECK / 3))
      @monstros << Monstro.new(Faker::Games::DnD.monster, [1, 2, 3].sample, [0, 1, 2, 3, 4].sample,
                                                   [1, 2, 3, 4, 5].sample)
    end
    until @terrenos.size == (QTD_DECK / 3)
      @terrenos << Terreno.new(%w[Pantano Planicie Ilha Montanha Floresta].sample)
    end
  end

  def comprar_carta(qtd)
    @todos.pop(qtd)
  end

  def embaralhar
    # @monstros.each { |_monstro| @todos.push(@monstros.pop) } unless @monstros.empty?
    # @terrenos.each { |_monstro| @todos.push(@terrenos.pop) } unless @terrenos.empty?
    @monstros.each do |monstro|
      @todos.push(monstro)
    end
    @monstros = []
    @terrenos.each do |terreno|
      @todos.push(terreno)
    end
    @terrenos = []
    @todos.shuffle
  end

end
