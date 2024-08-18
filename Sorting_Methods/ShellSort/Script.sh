#!/bin/bash

echo "Compilando Shell Sort..."
as ShellSort.s -o ShellSort.o -32
echo "Compilação Realizada com Sucesso!!"

echo "Linkando Biblioteca de 32bits..."
ld ShellSort.o -lc -dynamic-linker /lib/ld-linux.so.2 -o ShellSort -m elf_i386

echo "Inicializando Shell Sort..."
./ShellSort
