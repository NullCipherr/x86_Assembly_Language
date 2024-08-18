#!/bin/bash

echo "Compilando Heap Sort..."
as HeapSort.s -o HeapSort.o -32
echo "Compilação Realizada com Sucesso!!"

echo "Linkando Biblioteca de 32bits..."
ld HeapSort.o -lc -dynamic-linker /lib/ld-linux.so.2 -o HeapSort -m elf_i386

echo "Inicializando Heap Sort..."
./HeapSort
