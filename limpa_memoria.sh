#!/bin/bash
#
echo "Limpando a memória cache..."

# Sincroniza os dados do sistema de arquivoscom o disco
sync

# Limpa a página de cache
echo 1 > /proc/sys/vm/drop_caches
echo "Cache de página limpa."
sleep 2

# Limpa a página de dentries e inodes
#echo 2 > /proc/sys/vm/drop_caches
#echo "Dentries e inodes limpos."
#sleep 2

# Limpa todaa memória cache (páginas, dentries e inodes)
#echo 3 > /proc/sys/vm/drop_caches
#echo "Toda a memória cache limpa."
#sleep 2

# Informa que a limpeza foi concluída
echo "Memória cache limpa com sucesso!"
