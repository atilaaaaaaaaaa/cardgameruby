require 'game'
require 'player'
require 'colorize'

puts 'Type player 1 name:'
name1 = gets.chomp
player1 = Player.new(name1)
puts 'Type player 2 name:'
name2 = gets.chomp
player2 = Player.new(name2)

game = Game.new(player1, player2)
game.start