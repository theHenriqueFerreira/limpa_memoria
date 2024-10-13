Limpador de Memória para MK-AUTH
Este repositório contém scripts para limpar a memória cache do sistema em servidores que utilizam MK-AUTH. Ele inclui um script de limpeza de memória (limpa_memoria.sh) e um instalador que configura o cron para execução periódica do script (instala_limpador.sh).

Scripts
limpa_memoria.sh
Este script limpa a memória cache do sistema, ajudando a liberar recursos. Ele executa as seguintes etapas:

Sincroniza os dados do sistema de arquivos com o disco.
Limpa a cache de páginas.
Limpa dentries e inodes.
Limpa toda a memória cache (páginas, dentries e inodes).
instala_limpador.sh
Este script instala o limpador de memória e configura uma tarefa cron para executá-lo automaticamente em um horário escolhido pelo usuário.

Instalação
Para instalar o limpador de memória e configurar a execução automática via cron, execute o seguinte comando no seu servidor:

bash
Copiar código
bash <(wget -qO- https://raw.githubusercontent.com/theHenriqueFerreira/limpa_memoria/main/instala_limpador.sh)
Durante a instalação, você será solicitado a definir a hora e os minutos em que deseja que o script seja executado diariamente.

Atualização
Se o script já estiver instalado, o instalador permitirá que você atualize o script e ajuste as configurações do cron.

Remoção
Caso deseje remover o script e o cron job por completo, execute o seguinte comando:

bash
Copiar código
(crontab -l | grep -v '/usr/local/bin/limpa_memoria.sh' | crontab -) && sudo rm /usr/local/bin/limpa_memoria.sh
Isso removerá o cron job configurado e deletará o script do seu sistema.

Exemplo de Uso
O script de limpeza de memória pode ser executado manualmente a qualquer momento com:

bash
Copiar código
sudo ./limpa_memoria.sh
Autor
Desenvolvido por Henrique Ferreira.

Licença
Este projeto é licenciado sob os termos da licença MIT. Veja o arquivo LICENSE para mais detalhes.
