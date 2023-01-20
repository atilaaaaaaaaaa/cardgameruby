require_relative '../carta'
require_relative '../grimorio'
require_relative '../monstro'
require_relative '../terreno'
require 'faker'
require 'test/unit'

class TestCarta < Test::Unit::TestCase

  def setup
    @@nome_terreno = %w[Pantano Planicie Ilha Montanha Floresta].sample
    @@terreno = Terreno.new(@@nome_terreno)
    @@nome_monstro = Faker::Games::DnD.monster
    @@custo_monstro = [1, 2, 3].sample
    @@ataque_monstro = [0, 1, 2, 3, 4].sample
    @@defesa_monstro = [1, 2, 3, 4, 5].sample
    @@monstro = Monstro.new(@@nome_monstro, @@custo_monstro, @@ataque_monstro, @@defesa_monstro)
    @@nome_carta = Faker::Games::DnD.monster
    @@custo_carta = [1, 2, 3].sample
    @@carta = Carta.new(@@nome_carta, @@custo_carta)
  end

  def test_initialize
    assert_equal(@@nome_carta, @@carta.nome)
    assert_equal(@@custo_carta, @@carta.custo)
  end

  def test_monstro?
    assert_equal(true, @@monstro.monstro?)
    assert_equal(false, @@terreno.monstro?)
    # assert_equal(false, @@carta.terreno?)
  end
  
  def test_terreno?
    assert_equal(true, @@terreno.terreno?)
    assert_equal(false, @@monstro.terreno?)
  end

  def test_virar
    assert_equal(false, @@carta.virada)
    @@carta.virar
    assert_equal(true, @@carta.virada)
  end

  def test_virada?
    @@carta.virada = false
    assert_equal(false, @@carta.virada?)
  end

  def test_desvirada?
    assert_equal(true, @@carta.desvirada?)
  end

end