#!/bin/bash

echo "Compilando Subtração..."
as Subtraction.s -o Subtraction.o -32
echo "Compilação Realizada com Sucesso!!"

echo "Linkando Biblioteca de 32bits..."
ld Subtraction.o -lc -dynamic-linker /lib/ld-linux.so.2 -o Subtraction -m elf_i386

echo "Inicializando Subtração..."
./Subtraction
