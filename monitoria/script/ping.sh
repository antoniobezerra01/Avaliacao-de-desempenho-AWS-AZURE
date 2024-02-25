#!/bin/bash

i=0
while [[ $i -le 300 ]]; do
        echo "$i"
        ping -c 1 [IP APLICACAO] | grep "time=" | awk -F"time=" '{print $2}' >> arquivo_saida.txt
        (( i += 1 ))
        sleep 1
done