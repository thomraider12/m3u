#!/bin/bash

# Obtém os nomes dos arquivos de entrada e saída dos argumentos do script
input_file=$1
output_file=$2

# Cria um arquivo de saída vazio
touch $output_file

# Variável para armazenar o número do canal
channel_number=1

# Itera em cada linha do arquivo de entrada
while read line; do
  # Se a linha começa com "#EXTINF", significa que é uma linha descrevendo um canal
  if [[ $line == "#EXTINF"* ]]; then
    # Adiciona o número do canal ao parâmetro tvg-chno
    line=$(echo $line | sed "s/tvg-name/tvg-chno=\"$channel_number\" tvg-name/")
    # Incrementa o número do canal em 1
    channel_number=$((channel_number+1))
  fi
  # Adiciona a linha ao arquivo de saída
  echo $line >> $output_file
done < $input_file
