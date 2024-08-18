#!/bin/bash

echo "Compilando Bubble Sort..."
as BubbleSort.s -o BubbleSort.o -32
echo "Compilação Realizada com Sucesso!!"

echo "Linkando Biblioteca de 32bits..."
ld BubbleSort.o -lc -dynamic-linker /lib/ld-linux.so.2 -o BubbleSort -m elf_i386

echo "Inicializando Bubble Sort..."
./BubbleSort
