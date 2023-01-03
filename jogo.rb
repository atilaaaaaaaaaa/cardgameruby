require 'mesa'
# Classe para controlar ações principais do jogo
class Jogo
  attr_reader :player1, :player2

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

  def iniciar
    puts 'Criando cartas...'
    raise 'Falta implementar.'
  end

  def sortear_cartas
    puts 'Sorteando cartas...'
    raise 'Falta implementar.'
  end

  def sortear_jogador
    puts 'Sorteando jogadores...'
    raise 'Falta implementar.'
  end

  def mostrar_opcoes
    puts 'Mostrando opções...'
    raise 'Falta implementar.'
  end

  def mostrar_status
    puts 'MESA'
    puts "Turno #{@jogo.player1} [Pv-20/20]"
    puts 'Terrenos: 0/2'
    puts 'Criaturas P1: [Carta 1(Indisponivel), Carta 2(Disponivel)]'
    puts ''
    puts "Turno #{@jogo.player2} [Pv-20/20]"
    puts 'Terrenos: 1/1'
    puts 'Criaturas P1: [Carta 1(Disponivel)]'
  end

  def selecionar_opcao(_opcao)
    puts 'Selecionando opção...'
    raise 'Falta implementar.'
  end

  def remover_criatura
    puts 'Removendo criatura...'
    raise 'Falta implementar.'
  end

  def verificar_vencendor
    puts 'Verificar vencedor...'
    raise 'Falta implementar.'
  end
end
