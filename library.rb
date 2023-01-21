require 'debug'

# Classe que reflete deck de cartas dos jogadores
class Library
  attr_accessor :all, :creatures, :lands

  LIB_MAX = 60

  def initialize
    @creatures = []
    @lands = []
    @all = []
    prepare_library
    shuffle
  end

  def prepare_library
    until @creatures.size == (LIB_MAX - (LIB_MAX / 3))
      @creatures << Creature.new(Faker::Games::DnD.monster, [1, 2, 3].sample, [0, 1, 2, 3, 4].sample,
                                                   [1, 2, 3, 4, 5].sample)
    end
    until @lands.size == (LIB_MAX / 3)
      @lands << Land.new(%w[Swamp Plains Island Mountain Forest].sample)
    end
  end

  def add(cards)
    cards.each do |card|
      @all.push(card)
    end
    @all.shuffle!
  end

  def draw_card(amt = 1)
    @all.pop(amt)
  end

  def shuffle
    @creatures.each do |creature|
      @all.push(creature)
    end
    @creatures = []
    @lands.each do |land|
      @all.push(land)
    end
    # cleaning lands
    @lands = []
    @all.shuffle!
  end

end
