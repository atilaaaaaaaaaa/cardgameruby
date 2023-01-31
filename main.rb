require_relative 'game'
require_relative 'player'
require_relative 'card'
require_relative 'creature'
require_relative 'land'
require 'colorize'
require 'socket'

puts 'Type your name:'
name = gets.chomp
player1 = Player.new(name)
player2 = nil

game = Game.new(player1, nil)

puts '1) Create game'
puts '2) Join game'
option = gets.chomp
case option
when '1'
  # server = TCPServer.open(2000)
  game.socket.start_server

  # serial_player1 = Marshal.dump(player1)
  loop do
    game.socket.accept
    serial_player2 = game.socket.server_get_obj
    game.socket.server_send_obj(player1)

    player2 = serial_player2
    game.player2 = player2
    game.decide_player
    actplay = game.active_player
    game.socket.server_send_obj(actplay)

    puts "#{actplay.name} starts"
    game.start
  end
when '2'
  game.socket.connect

  puts 'Connection established'
  # serial_player1 = Marshal.dump(player1)

  while true
    game.socket.client_send_obj(player1)
    serial_player2 = game.socket.client_get_obj
    player2 = serial_player2
    game.player2 = player2

    active_play = game.socket.client_get_obj
    puts "#{active_play.name} starts"
    game.initial_player = active_play
    game.start
  end

else
  puts 'Invalid option'
end

# name1 = gets.chomp
# player1 = Player.new(name1)
# puts 'Type player 2 name:'
# player2 = Player.new(name2)

# game = Game.new(player1, player2)
# game.start
