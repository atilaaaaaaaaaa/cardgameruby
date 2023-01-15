require 'jogo'
require 'faker'
require 'debug'

ataque = [0..20].sample
resistencia = [1..20].sample

monstro1 = Monstro.new('atacante', 1, 5, 2)
monstro2 = Monstro.new('defensor', 1, 11, 1)

atila = Jogador.new('atila')
vitorio = Jogador.new('vitorio')
jogo = Jogo.new(atila, vitorio)
jogo.combate(monstro1, monstro2)
if monstro1.defesa.negative? && monstro2.defesa.negative?
  puts 'ok'
else
  puts 'erro'
end

puts 'testando defensor nulo'
atila.turno = false
vitorio.turno = true
jogo.combate(monstro1, nil)
jogo.combate(monstro1, nil)
if atila.vida == 10 && vitorio.vida == 20
  puts 'ok'
else
  puts 'erro'
end