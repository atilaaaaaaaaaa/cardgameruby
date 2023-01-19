require_relative '../carta'
require_relative '../monstro'
require_relative '../terreno'
require 'faker'
require 'test/unit'

class TestMonstro < Test::Unit::TestCase

  def setup
    @@nome_monstro = Faker::Games::DnD.monster
    @@custo_monstro = [1, 2, 3].sample
    @@ataque_monstro = [0, 1, 2, 3, 4].sample
    @@defesa_monstro = [1, 2, 3, 4, 5].sample
    @@monstro = Monstro.new(@@nome_monstro, @@custo_monstro, @@ataque_monstro, @@defesa_monstro)
  end
  

  def test_initialize
    assert_equal(@@nome_monstro, @@monstro.nome)
    assert_equal(@@custo_monstro, @@monstro.custo)
    assert_equal(@@ataque_monstro, @@monstro.ataque)
    assert_equal(@@defesa_monstro, @@monstro.defesa)
    assert_equal(false, @@monstro.defendendo)
    assert_equal(@@defesa_monstro, @@monstro.pts_vida)
    assert_equal(true, @@monstro.enjoo)
  end

  def test_enjoada
    @@monstro.enjoo = false
    assert_equal(false, @@monstro.enjoada?)
  end

  def test_pode_atacar?
    monstro = @@monstro.dup
    monstro.enjoo = true
    monstro.virar
    assert_equal(false, monstro.pode_atacar?)
    monstro.enjoo = false
    monstro.virada = false
    assert_equal(true, monstro.pode_atacar?)
  end

  def test_defesa_disponivel?
    monstro = @@monstro.dup
    monstro.defendendo = true
    assert_equal(false, monstro.defesa_disponivel?)
  end
end