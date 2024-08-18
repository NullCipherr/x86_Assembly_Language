#!/bin/bash

echo "Compilando Quick Sort..."
as QuickSort.s -o QuickSort.o -32
echo "Compilação Realizada com Sucesso!!"

echo "Linkando Biblioteca de 32bits..."
ld QuickSort.o -lc -dynamic-linker /lib/ld-linux.so.2 -o QuickSort -m elf_i386

echo "Inicializando Quick Sort..."
./QuickSort
