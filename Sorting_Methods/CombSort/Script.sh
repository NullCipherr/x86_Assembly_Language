#!/bin/bash

echo "Compilando Comb Sort..."
as CombSort.s -o CombSort.o -32
echo "Compilação Realizada com Sucesso!!"

echo "Linkando Biblioteca de 32bits..."
ld CombSort.o -lc -dynamic-linker /lib/ld-linux.so.2 -o CombSort -m elf_i386

echo "Inicializando Comb Sort..."
./CombSort
