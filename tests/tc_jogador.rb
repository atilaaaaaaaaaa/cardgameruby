require_relative '../carta'
require_relative '../grimorio'
require_relative '../monstro'
require_relative '../terreno'
require_relative '../jogador'
require 'faker'
require 'test/unit'

class TestJogador < Test::Unit::TestCase

  def setup
    @@nome = Faker::Games::HalfLife::character
    @@jogador = Jogador.new(@@nome)
  end

  def test_initialize
    assert_equal(@@nome, @@jogador.nome)
    assert_equal(0, @@jogador.mao.size)
    assert_equal(Jogador::QTD_VIDA, @@jogador.vida)
    assert_instance_of(Grimorio, @@jogador.grimorio)
    assert_equal(false, @@jogador.turno)
    assert_equal(0, @@jogador.cartas_baixadas.size)
  end

  def test_desvirar_cartas
    @@jogador.cartas_baixadas.push(Carta.new('carta', 2))
    @@jogador.cartas_baixadas.push(Terreno.new('terreno'))
    @@jogador.cartas_baixadas.push(Monstro.new('monstro', 3, 2, 2))
    @@jogador.desvirar_cartas
    @@jogador.cartas_baixadas.map { |carta| carta.virada? }.all?
  end

  def test_terrenos_baixados
    @@jogador.cartas_baixadas.push(Terreno.new('terreno 2'))
    assert_equal(1, @@jogador.terrenos_baixados.size)
  end

  def test_criaturas_baixadas
    @@jogador.cartas_baixadas.push(Monstro.new('monstro 2', 3, 2, 2))
    assert_equal(1, @@jogador.criaturas_baixadas.size)
  end

  def test_terrenos_baixados_desvirados
    @@jogador.cartas_baixadas.push(Terreno.new('terreno 3'))
    @@jogador.cartas_baixadas.first.virar
    @@jogador.cartas_baixadas.push(Terreno.new('terreno 4'))
    assert_not_equal(2, @@jogador.terrenos_baixados_desvirados.size)
  end

end