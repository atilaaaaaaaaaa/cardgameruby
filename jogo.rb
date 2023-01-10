require 'mesa'
require 'monstro'
require 'terreno'
require 'faker'
require 'jogador'
require 'colorize'

# Classe para controlar ações principais do jogo
class Jogo
  attr_reader :player1, :player2, :cartas

  QTD_MAO = 7

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @opcoes = { 1 => :comprar_carta, 2 => :abandonar_jogo, 3 => :mostrar_cartas, 4 => :atacar, 5 => :defender,
                6 => :terminar_turno }
  end

  def iniciar
    puts sortear_jogador
    @player1.grimorio.comprar_carta(7).each do |carta|
      @player1.mao.push(carta)
    end
    @player2.grimorio.comprar_carta(7).each do |carta|
      @player2.mao.push(carta)
    end

    until terminado?
      mostrar_mesa_v2
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
    jogador_aux = [player1, player2].sample
    if jogador_aux == player1
      player1.turno = true
    else
      player2.turno = true
    end
    puts "#{jogador_aux.nome} começa!"
  end

  def comprar_carta(qtd = 1)
    jogador_da_vez.mao.push(jogador_da_vez.grimorio.comprar_carta(qtd))
  end

  def jogador_da_vez
    if player1.turno == true
      @player1
    elsif player2.turno == true
      @player2
    else
      puts 'Nenhum jogador foi sorteado!'
    end
  end

  def mostrar_cartas
    cartas_hash = {}
    letra = 'A'
    puts 'Digite a letra para invocar uma carta'
    jogador_da_vez.mao.each do |carta|
      if carta.is_a?(Monstro)
        puts " #{letra} - #{carta.nome} - (Custo:#{carta.custo}) - (#{carta.ataque}/#{carta.defesa})"
        cartas_hash[letra] = carta # guardando num hash as opções de cada carta
      end
      puts " #{letra} - #{carta.nome} - Terreno" if carta.is_a?(Terreno)
      cartas_hash[letra] = carta # guardando num hash as opções de cada carta
      letra.next!
    end
    puts 'V - Voltar'
    opcao = gets.chomp
    case opcao
    when 'V'
      return
    when *cartas_hash.keys # * é um splat operator, que transforma arrays em strings separados por vírgulas(entre outras coisas)
      baixar_carta(cartas_hash[opcao])
    else
      raise 'else'
    end

    nil
  end

  def baixar_carta(carta)
    jogador_da_vez.cartas_baixadas.push(carta)
    jogador_da_vez.mao.delete(carta)
  end

  def mostrar_opcoes
    puts 'Mostrando opções...'
    puts ''
    puts "TURNO #{jogador_da_vez.nome}"
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
    nil
  end

  # def mostrar_mesa
  #   puts 'MESA'
  #   puts "Grimorio @todos: #{player1.grimorio.todos.size}"
  #   puts "#{player1.nome} [Pv-#{player1.vida}/#{Jogador::QTD_VIDA}]".colorize(:blue)
  #   puts "Cartas na mão: #{player1.mao.size} cartas"
  #   puts 'Terrenos: 0/2'
  #   puts 'Criaturas P1: [Carta 1(Indisponivel), Carta 2(Disponivel)]'
  #   puts ''
  #   puts "Grimorio @todos: #{player2.grimorio.todos.size}"
  #   puts "#{player2.nome} [Pv-#{player2.vida}/#{Jogador::QTD_VIDA}]".colorize(:blue)
  #   puts "Cartas na mão: #{player2.mao.size} cartas"
  #   puts 'Terrenos: 1/1'
  #   puts 'Criaturas P1: [Carta 1(Disponivel)]'
  #   nil
  # end

  def imprimir_terrenos_criaturas(cartas)
    monstros = cartas.map { |carta| carta if carta.monstro? }.compact || []
    terrenos = cartas.map { |carta| carta if carta.terreno? }.compact || []
    imprimir_cartas(monstros)
    imprimir_cartas(terrenos)
  end

  def imprimir_cartas(cartas)
    separator = '_____        '
    header =      ''
    default =     '|@@@@@|      '
    atk_dfs =     ''
    nome = ''

    cartas.flatten.each do |carta|
      header << "|@@@ #{carta.custo}|      "
      atk_dfs << (carta.monstro? ? "| #{carta.ataque}/#{carta.defesa} |      " : default)
      nome << "#{carta.nome[0..6]}       "
    end
    puts "##{separator * cartas.size}
##{header}
##{default * cartas.size}
##{default * cartas.size}
##{atk_dfs}
##{default * cartas.size}
##{nome}"
  end

  def mostrar_mesa_v2
    system 'clear'
    puts "########################### #{player1.nome} [Pv-#{player1.vida}/#{Jogador::QTD_VIDA}] ###########################".colorize(:red)
    puts imprimir_terrenos_criaturas(player1.cartas_baixadas)
    puts '#'
    puts '#'
    puts '#'
    puts '#'
    puts '#'
    puts '#' * 90
    puts imprimir_terrenos_criaturas(player2.cartas_baixadas)
    puts '#'
    puts '#'
    puts '#'
    puts '#'
    puts '#'
    puts '#'
    puts '#'
    puts "########################### puts #{player2.nome} [Pv-#{player2.vida}/#{Jogador::QTD_VIDA}] ###########################".colorize(:blue)
    nil
  end

  def selecionar_opcao(opcao)
    puts opcao
    puts @opcoes
    send(@opcoes[opcao.to_i])
    puts 'Selecionando opção...'
    nil
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
