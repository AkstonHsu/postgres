#!/bin/bash 
cd /home/postgres/PGDev/postgresql-12.5
source ../env-debug
./configure --prefix=$PGHOME --enable-debug
make -j56
make install