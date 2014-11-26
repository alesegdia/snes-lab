#!/usr/bin/env bash

echo '[objects]' > linkfile
echo $1.obj >> linkfile

wla-65816 -o $1.asm $1.obj
wlalink -vr linkfile $1.smc

rm $1.obj
rm linkfile
