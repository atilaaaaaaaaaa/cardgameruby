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

puts '1) Create game'
puts '2) Join game'
option = gets.chomp
case option
when '1'
  server = TCPServer.open(2000)

  serial_player1 = Marshal.dump(player1)
  loop do
    client = server.accept
    str = client.recv(5000)
    serial_player2 = Marshal.load(str)
    client.write(serial_player1)

    player2 = serial_player2
    game = Game.new(player1, player2)
    game.decide_player
    actplay = game.active_player
    actplayer = Marshal.dump(actplay)
    client.write(actplayer)

    puts "#{actplay.name} starts"
    game.start
  end
when '2'
  hostname = 'localhost'
  port = 2000

  s = TCPSocket.open(hostname, port)

  puts 'Connection established'
  serial_player1 = Marshal.dump(player1)

  while true
    s.puts(serial_player1)
    str = s.recv(5000)
    serial_player2 = Marshal.load(str)
    player2 = serial_player2

    game = Game.new(player1, player2)

    actplayer = s.recv(5000)
    active_play = Marshal.load(actplayer)
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
