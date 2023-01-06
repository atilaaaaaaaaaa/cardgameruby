require 'mesa'
require 'monstro'
require 'terreno'
require 'faker'
require 'jogador'
# Classe para controlar ações principais do jogo
class Jogo
  attr_reader :player1, :player2, :cartas, :monstros, :terrenos, :jogador_da_vez

  QTD_MAO = 7
  QTD_JOGO = 120

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @monstros = []
    @terrenos = []
    @opcoes = { 1 => :comprar_carta, 2 => :abandonar_jogo, 4 => :atacar, 5 => :defender, 6 => :terminar_turno }
  end

  def gerando_cartas(quantidade)
    # loop de criaturas
    (1..quantidade).each do
      monstros << Monstro.new(Faker::Games::DnD.monster, [1, 2, 3].sample, [0, 1, 2, 3, 4].sample,
                              [1, 2, 3, 4, 5].sample)
    end
    # loop de terrenos
    'Cartas geradas com sucesso'
  end

  def iniciar
    puts gerando_cartas(QTD_JOGO)
    puts sortear_cartas
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

  def todas_cartas
    terrenos + monstros
  end

  def sortear_cartas
    while player1.mao.size < QTD_MAO
      @player1.mao.push(monstros.pop)
      @player2.mao.push(monstros.pop)
      @player1.mao << Terreno.new(%w[Pantano Planicie Ilha Montanha Floresta].sample) if player1.mao.size < QTD_MAO
      @player2.mao << Terreno.new(%w[Pantano Planicie Ilha Montanha Floresta].sample) if player2.mao.size < QTD_MAO
    end
    'Cartas sorteadas com sucesso'
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
    puts "Turno #{player1} [Pv-#{player1.vida}/#{Jogador::QTD_VIDA}]"
    puts 'Terrenos: 0/2'
    puts 'Criaturas P1: [Carta 1(Indisponivel), Carta 2(Disponivel)]'
    puts ''
    puts "Turno #{player2} [Pv-#{player2.vida}/#{Jogador::QTD_VIDA}]"
    puts 'Terrenos: 1/1'
    puts 'Criaturas P1: [Carta 1(Disponivel)]'
  end

  def selecionar_opcao(opcao)
    puts opcao
    puts @opcoes
    self.send(@opcoes[opcao.to_i])
    puts 'Selecionando opção...'
    raise 'Falta implementar.'
  end

  def comprar_carta
    puts "Comprei uma carta"
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
