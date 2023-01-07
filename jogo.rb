require 'mesa'
require 'monstro'
require 'terreno'
require 'faker'
require 'jogador'
# Classe para controlar ações principais do jogo
class Jogo
  attr_reader :player1, :player2, :cartas, :jogador_da_vez

  QTD_MAO = 7

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @opcoes = { 1 => :comprar_carta, 2 => :abandonar_jogo, 4 => :atacar, 5 => :defender, 6 => :terminar_turno }
  end

  def iniciar
    #player1.grimorio.comprar_carta(7)
    #player2.grimorio.comprar_carta(7)
    puts sortear_jogador

    until terminado?
      mostrar_mesa
      mostrar_opcoes
      opcao = gets.chomp
      selecionar_opcao(opcao)
    end
    puts 'Jogo terminou.'
  end

  def terminado?
    player1.vida <= 0 || player2.vida <= 0
  end

  def sortear_jogador
    @jogador_da_vez = [player1, player2].sample
    puts "#{@jogador_da_vez.nome} começa!"
  end

  def mostrar_cartas
    letra = 'A'
    @jogador_da_vez.mao.each do |carta|
      if carta.is_a?(Monstro)
        puts " #{letra} - #{carta.nome} - (Custo:#{carta.custo}) - (#{carta.ataque}/#{carta.defesa})"
      end
      puts " #{letra} - #{carta.nome} - Terreno" if carta.is_a?(Terreno)
      letra.next!
    end
    nil
  end

  def mostrar_opcoes
    puts 'Mostrando opções...'
    puts ''
    puts "TURNO #{@jogador_da_vez.nome}"
    @opcoes.each do |key, value|
      puts "#{key} - #{value}"
    end
    # puts '1 - comprar carta'
    # puts '2 - abandonar o jogo'
    # puts '3 - ver cartas'
    # puts "#{mostrar_cartas}"
    # puts '4 - Atacar'
    # puts '  A - Carta 1(Indisponivel)'
    # puts '  B - Carta 2(Disponivel)'
    # puts '5 - Defender'
    # puts '  A - Carta 1(Indisponivel)'
    # puts '  B - Carta 2(Disponivel)'
    # puts '6 - Terminar turno'
  end

  def mostrar_mesa
    puts 'MESA'
    puts "Grimorio: #{player1.grimorio.monstros.size} monstros / #{player1.grimorio.terrenos.size} terrenos"
    puts "Turno #{player1.nome} [Pv-#{player1.vida}/#{Jogador::QTD_VIDA}]"
    puts 'Terrenos: 0/2'
    puts 'Criaturas P1: [Carta 1(Indisponivel), Carta 2(Disponivel)]'
    puts ''
    puts "Grimorio: ##{player2.grimorio.monstros.size} monstros / #{player2.grimorio.terrenos.size} terrenos"
    puts "Turno #{player2.nome} [Pv-#{player2.vida}/#{Jogador::QTD_VIDA}]"
    puts 'Terrenos: 1/1'
    puts 'Criaturas P1: [Carta 1(Disponivel)]'
  end

  def selecionar_opcao(opcao)
    puts opcao
    puts @opcoes
    send(@opcoes[opcao.to_i])
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
