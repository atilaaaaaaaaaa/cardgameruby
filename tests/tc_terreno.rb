require_relative '../carta'
require_relative '../monstro'
require_relative '../terreno'
require 'faker'
require 'test/unit'

class TestTerreno < Test::Unit::TestCase

  def test_initialize
    nome_terreno = %w[Pantano Planicie Ilha Montanha Floresta].sample
    terreno = Terreno.new(nome_terreno)
    assert_equal(nome_terreno, terreno.nome)

  end

end