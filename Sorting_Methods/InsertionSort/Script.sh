#!/bin/bash

echo "Compilando Insertion Sort..."
as InsertionSort.s -o InsertionSort.o -32
echo "Compilação Realizada com Sucesso!!"

echo "Linkando Biblioteca de 32bits..."
ld InsertionSort.o -lc -dynamic-linker /lib/ld-linux.so.2 -o InsertionSort -m elf_i386

echo "Inicializando Insertion Sort..."
./InsertionSort
