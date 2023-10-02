#!/bin/bash

echo "Compilando Hello World..."
as HelloWorld.s -o HelloWorld.o -32
echo "Compilação Realizada com Sucesso!!"

echo "Linkando Biblioteca de 32bits..."
ld HelloWorld.o -lc -dynamic-linker /lib/ld-linux.so.2 -o HelloWorld -m elf_i386

echo "Inicializando Hello World..."
./HelloWorld
