require 'jogo'
require 'faker'
require 'debug'

monstro1 = Monstro.new('atacante', 1, 1, 2)
monstro2 = Monstro.new('defensor', 1, 2, 1)

jogo = Jogo.new(Jogador.new('atila'), Jogador.new('vitorio'))
jogo.combate(monstro1, monstro2)
if monstro1.defesa.zero? && monstro2.defesa.zero?
  puts 'ok'
else
  puts 'erro'
end