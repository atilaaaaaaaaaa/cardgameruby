require 'mesa'
require 'monstro'
require 'terreno'
require 'faker'
# Classe para controlar ações principais do jogo
class Jogo
  attr_reader :player1, :player2, :cartas, :monstros, :terrenos

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @monstros = []
    @terrenos = []
  end

  def gerando_cartas(quantidade)
    # loop de criaturas
    (1..quantidade).each do
      monstros << Monstro.new(Faker::Games::DnD.monster, [1, 2, 3].sample, [0, 1, 2, 3, 4].sample,
                              [1, 2, 3, 4, 5].sample)
    end
    # loop de terrenos
    (1..(quantidade / 2)).each do
      terrenos << Terreno.new(%w[Pantano Planicie Ilha Montanha Floresta].sample)
    end
    'Cartas geradas com sucesso'
  end

  def iniciar
    puts 'Criando cartas...'
    # 120 cartas?
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
