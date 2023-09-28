#!/bin/bash

echo "Compilando - Assembly x86 - Soma Ponto Flutuante..."
as Soma_Ponto_Flutuante.s -o Soma_Ponto_Flutuante.o -32
echo "Compilação Realizada com Sucesso!!"

echo "Linkando Biblioteca de 32bits..."
ld Soma_Ponto_Flutuante.o -lc -dynamic-linker /lib/ld-linux.so.2 -o Soma_Ponto_Flutuante -m elf_i386

echo "Inicializando a Soma do Ponto Flutuante..."
./Soma_Ponto_Flutuante
