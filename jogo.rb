require 'mesa'
require 'monstro'
require 'terreno'
require 'faker'
require 'jogador'
require 'colorize'
require 'regras'

# Classe para controlar ações principais do jogo
class Jogo
  attr_reader :player1, :player2, :cartas

  QTD_MAO = 7

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @opcoes = { 1 => :comprar_carta, 2 => :abandonar_jogo, 3 => :mostrar_cartas, 4 => :mostrar_opcoes_ataque, 5 => :mostrar_opcoes_defesa,
                6 => :terminar_turno }
    @alerts = []
    @criaturas_atacantes = []
    @criaturas_defensoras = []
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
    jogador_da_vez.mao.concat(jogador_da_vez.grimorio.comprar_carta(qtd))
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

  def oponente
    return player1 if player1.turno == false

    player2
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
    return @alerts << 'Mana insuficiente' if carta.custo > jogador_da_vez.terrenos_baixados.size
    jogador_da_vez.cartas_baixadas.push(carta)
    jogador_da_vez.terrenos_baixados.first(carta.custo).map { |terreno| terreno.virar }
    jogador_da_vez.mao.delete(carta)
  end

  def abandonar_jogo
    puts 'Tem certeza que quer sair do jogo?(Y/N)'
    opcao = gets.chomp
    case opcao
    when 'Y'
      exit
    when 'N'
      nil
    else
      puts 'Opção inválida'
      nil
    end
  end

  def mostrar_opcoes
    puts 'Mostrando opções...'
    puts ''
    puts "TURNO #{jogador_da_vez.nome}"
    @opcoes.each do |key, value|
      puts "#{key} - #{value}"
    end
    nil
  end

  def imprimir_terrenos_criaturas(cartas)
    monstros = cartas.map { |carta| carta if carta.monstro? }.compact || []
    terrenos = cartas.map { |carta| carta if carta.terreno? }.compact || []
    imprimir_cartas(monstros)
    imprimir_cartas(terrenos)
  end

  def imprimir_cartas(cartas)
    separator = '_____        '
    header =      ''
    default =     ''
    atk_dfs =     ''
    nome = ''
    cor = :blue

    cartas.flatten.each do |carta|
      cor = carta.virada? ? :red : :blue
      header << "|@@@ #{carta.custo}|      ".colorize(cor)
      atk_dfs << ((carta.monstro? ? "| #{carta.ataque}/#{carta.defesa} |      " : '|@@@@@|      ')).colorize(cor)
      nome << "#{carta.nome[0..6]}       ".colorize(cor)
      default << '|@@@@@|      '.colorize(cor)
    end
    result = "##{separator * cartas.size}
##{header}
##{default}
##{default}
##{atk_dfs}
##{default}
##{nome}"
    puts result
  end

  def mostrar_mesa_v2
    puts "################################# #{player1.nome} [Pv-#{player1.vida}/#{Jogador::QTD_VIDA}] #################################".colorize(:green)
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
    puts @alerts.join(', ').colorize(:red)
    @alerts = []
    nil
  end

  def selecionar_opcao(opcao)
    puts opcao
    puts @opcoes
    send(@opcoes[opcao.to_i])
    puts 'Selecionando opção...'
    nil
  end

  def mostrar_opcoes_ataque
    cartas_hash = {}
    letra = 'A'
    opcao = ''
    while opcao != 'G'
      jogador_da_vez.criaturas_baixadas.each do |carta|
        if carta.desvirada?
          puts " #{letra} - #{carta.nome} - (Custo:#{carta.custo}) - (#{carta.ataque}/#{carta.defesa})"
          cartas_hash[letra] = carta # guardando num hash as opções de cada carta
        end
        letra.next!
      end
      puts 'V - Voltar'
      puts 'G - Finalizar ataque'
      opcao = gets.chomp
      
      case opcao
      when 'V'
        return
      when *cartas_hash.keys
        @criaturas_atacantes << cartas_hash[opcao]
        cartas_hash[opcao].virada = true
      when 'G'
        mostrar_opcoes_defesa
      else
        raise 'erro nas opções de ataque'
      end
    end

    nil
  end

  def mostrar_opcoes_defesa
    cartas_hash = {}
    letra = 'A'
    opcao = ''
    while opcao != 'X'
      oponente.criaturas_baixadas.each do |carta|
        if carta.desvirada?
          puts " #{letra} - #{carta.nome} - (Custo:#{carta.custo}) - (#{carta.ataque}/#{carta.defesa})"
          cartas_hash[letra] = carta # guardando num hash as opções de cada carta
        end
        letra.next!
      end
      puts 'V - Voltar'
      puts 'X - Finalizar defesa'
      puts 'Z - limpar seleção'
      opcao = gets.chomp
      binding.break
      case opcao
      when 'V'
        return
      when *cartas_hash.keys
        @criaturas_defensoras << cartas_hash[opcao]
      when 'X'
        resolver_combate
      when 'Z'
        @criaturas_defensoras = []
        return
      else
        raise 'erro nas opções de defesa'
      end
    end

    nil
  end

  def resolver_combate
    @criaturas_atacantes.each_with_index do |criatura_atacante, index|
      combate(criatura_atacante, @criaturas_defensoras[index])
    end
  end

  def combate(atacante, defensor)
    if defensor.nil?
      oponente.vida -= atacante.ataque
    else
      defensor.defesa -= atacante.ataque
      atacante.defesa -= defensor.ataque
    end
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
