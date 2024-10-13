#!/bin/bash

echo "Limpando a memória cache..."
sync; echo 1 > /proc/sys/vm/drop_caches
sync; echo 2 > /proc/sys/vm/drop_caches
sync; echo 3 > /proc/sys/vm/drop_caches
echo "Memória cache limpa com sucesso!"

