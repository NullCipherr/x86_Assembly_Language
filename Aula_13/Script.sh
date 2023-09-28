#!/bin/bash

echo "Compilando Ponto Flutuante..."
as Ponto_Flutuante.s -o Ponto_Flutuante.o -32
echo "Compilação Realizada com Sucesso!!"

echo "Linkando Biblioteca de 32bits..."
ld Ponto_Flutuante.o -lc -dynamic-linker /lib/ld-linux.so.2 -o Ponto_Flutuante -m elf_i386

echo "Inicializando Ponto Flutuante..."
./Ponto_Flutuante
