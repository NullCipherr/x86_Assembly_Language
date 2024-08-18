#!/bin/bash

echo "Compilando Selection Sort..."
as SelectionSort.s -o SelectionSort.o -32
echo "Compilação Realizada com Sucesso!!"

echo "Linkando Biblioteca de 32bits..."
ld SelectionSort.o -lc -dynamic-linker /lib/ld-linux.so.2 -o SelectionSort -m elf_i386

echo "Inicializando Selection Sort..."
./SelectionSort
