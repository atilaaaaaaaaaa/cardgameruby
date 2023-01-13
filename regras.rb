class Regras

  def self.mana_insuficiente(carta, jogador_da_vez)
  return 'Mana insuficiente' if carta.custo > jogador_da_vez.terrenos_baixados.size

  nil
  end
end