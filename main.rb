require 'jogo'
require 'mesa'

puts 'Digite o nome do player1:'
nome1 = gets.chomp
puts 'Digite o nome do player2:'
nome2 = gets.chomp

jogo = Jogo.new(nome1, nome2)

mesa = Mesa.new(jogo)
mesa.imprimir

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

# TURNO PLAYER 1
# opcoes
# 1 - comprar carta
# 2 - abandonar o jogo
# 3 - ver cartas
#   A - Carta 1(Custo:4) - Criatura Zumbi - (2/3)
#   B - Carta 2(Custo:1) - Criatura Zumbi - (1/1)
#   C - Carta 3(Custo:2) - Criatura Zumbi - (2/1)
#   D - Carta 4(Custo:3) - Criatura Vampiro - (3/1)
#   E - Carta 5(Custo:4) - Criatura Vampiro - (2/3)
#   F - Carta 6(Custo: 0) - Terreno
#   G - Carta 7(Custo: 0) - Terreno
# 4 - Atacar
#   A - Carta 1(Indisponivel)
#   B - Carta 2(Disponivel)
# 5 - Defender
#   A - Carta 1(Indisponivel)
#   B - Carta 2(Disponivel)
# 6 - Terminar turno

# começando jogo
# jogo = Jogo.new(nome1, nome2)
# jogo.iniciar
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
