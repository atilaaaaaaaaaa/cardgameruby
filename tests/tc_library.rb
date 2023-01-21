require_relative '../card'
require_relative '../library'
require_relative '../creature'
require_relative '../land'
require 'faker'
require 'test/unit'

class TestLibrary < Test::Unit::TestCase

  def test_initialize
    library = Library.new
    assert_equal(0, library.creatures.size)
    assert_equal(0, library.lands.size)
    assert_equal(60, library.all.size)
  end

  def test_prepare_library
    library = Library.new
    library.prepare_library
    assert_equal(40, library.creatures.size)
    assert_equal(20, library.lands.size)
  end

  def test_add
    library = Library.new
    library.add([Card.new('test', 5)])
    assert_equal(61, library.all.size)
  end

  def test_draw_card
    library = Library.new
    amt = (1..10).to_a.sample
    library.draw_card(amt)
    assert_equal(60 - amt, library.all.size)
  end

  def test_shuffle
    library = Library.new
    result = library.all.first(7).map { |card| card.is_a?(Land) }.all?
    assert_equal(result, false)
  end

end