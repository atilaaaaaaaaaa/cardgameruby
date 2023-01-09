require 'jogo'
require 'mesa'
require 'jogador'
require 'colorize'

puts 'Digite o nome do player1:'
nome1 = gets.chomp
player1 = Jogador.new(nome1)
puts 'Digite o nome do player2:'
nome2 = gets.chomp
player2 = Jogador.new(nome2)

jogo = Jogo.new(player1, player2)
jogo.iniciar

# puts jogo.player1.mao.map{|a| a.nome}
# puts 'Cartas do outro jogador'
# puts jogo.player2.mao.flatten.map{|a| a.nome}
# Distribuição de 7 cartas
# Mostrar cartas parao o jogador
# Definir quem começa
# Player 1 compra uma carta
# baixa 1 carta de mana
# invoca uma criatura de mana 1
# ataca com a criatura
# termina turno seu turno

# ...Sorteando quem começa
# ...Distribuindo cartas

# começando jogo
# jogo = Jogo.new(nome1, nome2)
# jogo.inciar
# jogo.sortear_cartas
# jogo.sortear_jogador
# exit = false
# while(exit)
# jogo.desvirar_cartas
# jogo.mostrar_status
	# jogo.mostrar_opções
	# opcao = gets.chomp
	# jogo.selecionar_opcao(opcao)
	# jogo.remover_criatura
	# jogo.verificar_vencendor
# end

