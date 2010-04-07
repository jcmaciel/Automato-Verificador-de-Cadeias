#!/usr/bin/ruby

# Programa que verifica se uma cadeia pertence ou não de um automato
# lido de um arquivo texto padronizado com as informações do mesmo.
#
# José Carlos Maciel - UENF - 07/04/2010

class Automato
 attr "numeroDeEstados"
 attr "estadoInicial"
 attr "numeroDeEstados"
 attr "estados"
 attr "numeroDeEstadosFinais"
 attr "estadosFinais"
 attr "numeroDeTransicoes"
 attr "transicoes"

#Construtor
def initialize(arquivo)
txt = File.readlines(arquivo)

 @numeroDeEstados = txt[0]
 @estados = txt[1]
 @estadoInicial = txt[2]
 @numeroDeEstadosFinais = txt[3]
 @estadosFinais = txt[4]
 @numeroDeTransicoes = txt[5]
 @transicoes = txt[6].split("|")
end

#Funcao que testa as transicoes no automato
def transicao(estado,letra)
   achou=0
   @numeroDeTransicoes.to_i.times do |i|

   if estado.to_s + letra.to_s == @transicoes[i][0,2]
achou=1
return @transicoes[i][2,1]
   break
else
  achou=0
end
 end
if achou == 0
  return "0"
end
end

#Funcao principal que recebe a cadeia e divide-a em partes testando as transicoes atraves da #funcao acima
def verifica(cadeia)
  estadoAtual = @estadoInicial.chomp

  cadeia.length.times do |indice|

    if transicao(estadoAtual,cadeia[indice]) == 0
      break
else
        estadoAtual = transicao(estadoAtual,cadeia[indice])
end
end
puts "        Estado que parou: " + estadoAtual + " (Final? #{final(estadoAtual)})"
if final(estadoAtual) == true
  "        cadeia aceita"
else
  "        cadeia rejeitada"
end
end

#funcao que verifica se o estado é final ou nao
def final(estado)
if @estadosFinais.include? estado
  true
else
  false
end
end



end

def monta_header
  puts "\n        ################# Resultado ##################\n"
end

#Parte principal | pega nome do arquivo e cadeia de caracteres
print "Programa Linguagens Formais\n"
print "Digite o caminho para seu arquivo(sem extensao .txt) contendo o automato(padronizado):\n"
arquivo = gets
arquivo = arquivo.chomp + ".txt"
print "Digite a cadeia a ser testada:\n"
cadeia = gets
cadeia=cadeia.chomp


automato = Automato.new(arquivo)
monta_header()
puts automato.verifica(cadeia)

