require_relative 'card'
require_relative 'creature'
require_relative 'land'
require_relative 'player'
require_relative 'rules'
require 'faker'
require 'colorize'

# Classe para controlar ações principais do jogo
class Game
  attr_reader :player1, :player2, :cards

  amt_hand = 7

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @options = { 0 => :mulligan, 1 => :draw_card, 2 => :leave_game, 3 => :show_cards, 4 => :show_attack_options, 5 => :finish_turn }
    @alerts = []
    @attacking_creatures = []
    @blocking_creatures = []
  end

  def start
    puts decide_player
    @player1.library.draw_card(7).each do |card|
      @player1.hand.push(card)
    end
    @player2.library.draw_card(7).each do |card|
      @player2.hand.push(card)
    end

    until finished?
      show_table_v2
      show_options
      option = gets.chomp
      select_option(option)
    end
    puts 'Game over.'
  end

  def mulligan
    hand_cards = active_player.hand.size
    return if hand_cards == 1

    active_player.library.add(active_player.hand)
    active_player.hand = []

    active_player.library.draw_card(hand_cards - 1).each do |card|
      active_player.hand.push(card)
    end
  end

  def finished?
    player1.life <= 0 || player2.life <= 0
  end

  def decide_player
    aux_player = [player1, player2].sample
    if aux_player == player1
      player1.turn = true
    else
      player2.turn = true
    end
    puts "#{aux_player.name} starts!"
  end

  def draw_card(amt = 1)
    active_player.hand.concat(active_player.library.draw_card(amt))

  end

  def active_player
    if player1.turn == true
      @player1
    elsif player2.turn == true
      @player2
    else
      puts 'No player was chosen.'
    end
  end

  def opponent
    return player1 if player1.turn == false

    player2
  end

  def show_cards
    cards_hash = {}
    letter = 'A'
    puts 'Type the letter to play the card'
    active_player.hand.each do |card|
      if card.is_a?(Creature)
        puts " #{letter} - #{card.name} - (Cost:#{card.cost}) - (#{card.power}/#{card.toughness})"
        cards_hash[letter] = card # keeping in a hash each card's option
      end
      puts " #{letter} - #{card.name} - Land" if card.is_a?(Land)
      cards_hash[letter] = card
      letter.next!
    end
    puts 'V - Go back'
    option = gets.chomp
    case option
    when 'V'
      return
    when *cards_hash.keys # * é um splat operator, que transforma arrays em strings separados por vírgulas(entre outras coisas)
      play_card(cards_hash[option])
    else
      @alerts << 'Opção inválida'
      return
    end

    nil
  end

  def play_card(card)
    return @alerts << 'Insufficient Mana' if card.cost > active_player.played_untapped_lands.size

    active_player.played_cards.push(card)
    active_player.played_untapped_lands.first(card.cost).map { |land| land.tap }
    active_player.hand.delete(card)
  end

  def leave_game
    puts 'Are you sure you wanna leave?(Y/N)'
    option = gets.chomp
    case option
    when 'Y'
      exit
    when 'N'
      nil
    else
      puts 'Invalid option'
      nil
    end
    nil
  end

  def show_options
    puts 'Showing options...'
    puts ''
    puts "turn #{active_player.name}"
    @options.each do |key, value|
      puts "#{key} - #{value}"
    end
    nil
  end

  def print_lands_and_creatures(cards)
    creatures = cards.map { |card| card if card.creature? }.compact || []
    lands = cards.map { |card| card if card.land? }.compact || []
    print_cards(creatures)
    print_cards(lands)
  end

  def print_cards(cards)
    separator = '_____        '
    header =      ''
    default =     ''
    pwr_tghness =     ''
    name = ''
    color = :blue

    cards.flatten.each do |card|
      color = card.tapped? ? :red : :blue
      header << "|@@@ #{card.cost}|      ".colorize(color)
      pwr_tghness << ((card.creature? ? "| #{card.power}/#{card.life_pts} |      " : '|@@@@@|      ')).colorize(color)
      name << "#{card.name[0..6]}       ".colorize(color)
      default << '|@@@@@|      '.colorize(color)
    end
    result = "##{separator * cards.size}
##{header}
##{default}
##{default}
##{pwr_tghness}
##{default}
##{name}"
    puts result
  end

  def show_table_v2
    puts "################################# #{player1.name} [Pv #{player1.life}/#{Player::LIFE_PTS}] #################################".colorize(:green)
    puts print_lands_and_creatures(player1.played_cards)
    puts '#'
    puts '#'
    puts '#'
    puts '#'
    puts '#'
    puts '#' * 90
    puts print_lands_and_creatures(player2.played_cards)
    puts '#'
    puts '#'
    puts '#'
    puts '#'
    puts '#'
    puts '#'
    puts '#'
    puts "################################  #{player2.name} [Pv #{player2.life}/#{Player::LIFE_PTS}] ###########################".colorize(:blue)
    puts @alerts.join(', ').colorize(:red)
    @alerts = []
    nil
  end

  def select_option(option)
    puts option
    puts @options
    send(@options[option.to_i])
    puts 'Selecting options...'
    nil
  end

  def show_attack_options
    cards_hash = {}
    letter = 'A'
    option = ''
    while option != 'G'
      active_player.summoned_creatures.each do |card|
        if card.can_attack?
          puts " #{letter} - #{card.name} - (Cost:#{card.cost}) - (#{card.power}/#{card.toughness})"
          cards_hash[letter] = card # keeping in a hash each card's option
        end
        letter.next!
      end
      puts 'V - Cancel attack'
      puts 'G - Finish attack'
      option = gets.chomp

      case option
      when 'V'
        @attacking_creatures = []
        return
      when *cards_hash.keys
        @attacking_creatures << cards_hash[option] unless @attacking_creatures.include?(cards_hash[option])
        cards_hash[option].tapped = true
      when 'G'
        if opponent.summoned_creatures.empty? || opponent.summoned_creatures.map(&:tapped?).all?
          puts 'No creatures available to block'
        else
          show_blocking_options
        end
      else
        @alerts << 'Invalid option'
        return
      end
    end
    solve_combat
    nil
  end

  def show_blocking_options
    puts 'Select the blocking creatures, respectively.'
    cards_hash = {}
    letter = 'A'
    option = ''
    while option != 'X'
      opponent.summoned_creatures.each do |card|
        if card.untapped? && card.block_available?
          puts " #{letter} - #{card.name} - (Cost:#{card.cost}) - (#{card.power}/#{card.toughness})"
          cards_hash[letter] = card # Keeping in a hash each card's option
        end
        letter.next!
      end
      puts 'X - Finish blocking'
      puts 'Z - Clear selection'
      option = gets.chomp
      case option
      when *cards_hash.keys
        @blocking_creatures << cards_hash[option] unless @blocking_creatures.include?(cards_hash[option])
        cards_hash[option].blocking = true
      when 'X', 'x'
        return
      when 'Z', 'z'
        @blocking_creatures = []
        next
      else
        raise 'Error in the blocking options'
      end
    end
    nil
  end

  def solve_combat
    @attacking_creatures.each_with_index do |attacking_creature, index|
      combat(attacking_creature, @blocking_creatures[index])
      binding.break
    end
  end

  def combat(attacker, defender)
    if defender.nil?
      opponent.life -= attacker.power
    else
      defender.life_pts -= attacker.power
      attacker.life_pts -= defender.power
    end
  end

  def clear_creature
    active_player.summoned_creatures.each do |creature|
      if creature.life_pts <= 0
        active_player.played_cards.delete(creature)
      else
        creature.life_pts = creature.toughness
      end
    end

    opponent.summoned_creatures.each do |creature|
      if creature.life_pts <= 0
        opponent.played_cards.delete(creature)
      else
        creature.life_pts = creature.toughness
      end
    end

    @attacking_creatures = []
    @blocking_creatures = []
  end

  def finish_turn
    clear_creature
    if player1.turn == true
      player1.turn = false
      player2.turn = true
    else
      player2.turn = false
      player1.turn = true
    end
    opponent.untap_cards

    active_player.summoned_creatures.each do |creature|
      creature.sickness = false
    end
  end
end