#!/bin/bash

echo "Compilando Soma..."
as Sum.s -o Sum.o -32
echo "Compilação Realizada com Sucesso!!"

echo "Linkando Biblioteca de 32bits..."
ld Sum.o -lc -dynamic-linker /lib/ld-linux.so.2 -o Sum -m elf_i386

echo "Inicializando Soma..."
./Sum
