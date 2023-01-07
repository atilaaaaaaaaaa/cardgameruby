require 'grimorio'
require 'monstro'
require 'faker'
require 'terreno'


# Testes dos metodos de grimorio
grimorio = Grimorio.new

grimorio.preparar_grimorio
puts 'OK' if grimorio.monstros.size == 40
puts 'OK' if grimorio.terrenos.size == 20

grimorio = Grimorio.new

grimorio.preparar_grimorio
grimorio.embaralhar
if grimorio.todos.size == 60 && grimorio.monstros.size == 0 && grimorio.terrenos.size == 0
  puts 'ok'
else
  puts 'erro'
end

grimorio = Grimorio.new

grimorio.preparar_grimorio
grimorio.embaralhar
cartas = grimorio.comprar_carta(3)
if cartas.size == 3 && grimorio.todos.size == 57 && cartas.first.nome != ''
  puts 'ok'
else
  puts 'error'
end