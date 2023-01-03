class Carta
    attr_reader :nome, :custo, :ataque, :defesa, :habilidade
    def initialize(nome, custo, ataque, defesa, habilidade = nil)
        @nome = nome
        @custo = custo
        @ataque = ataque
        @defesa = defesa
        @habilidade = habilidade
    end
end