require_relative '../carta'
require_relative '../grimorio'
require_relative '../monstro'
require_relative '../terreno'
require 'faker'
require 'test/unit'

class TestGrimorio < Test::Unit::TestCase

  def test_initialize
    grimorio = Grimorio.new
    assert_equal(0, grimorio.monstros.size)
    assert_equal(0, grimorio.terrenos.size)
    assert_equal(60, grimorio.todos.size)
  end

  def test_preparar_grimorio
    grimorio = Grimorio.new
    grimorio.preparar_grimorio
    assert_equal(40, grimorio.monstros.size)
    assert_equal(20, grimorio.terrenos.size)
  end

  def test_add
    grimorio = Grimorio.new
    grimorio.add([Carta.new('teste', 5)])
    assert_equal(61, grimorio.todos.size)
  end

  def test_comprar_carta
    grimorio = Grimorio.new
    qtd = (1..10).to_a.sample
    grimorio.comprar_carta(qtd)
    assert_equal(60 - qtd, grimorio.todos.size)
  end

  def test_embaralhar
    grimorio = Grimorio.new
    result = grimorio.todos.first(7).map { |carta| carta.is_a?(Terreno) }.all?
    assert_equal(result, false)
  end

end