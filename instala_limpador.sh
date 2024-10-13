
#!/bin/bash

SCRIPT_NAME="limpa_memoria.sh"
SCRIPT_URL="https://raw.githubusercontent.com/theHenriqueFerreira/limpa_memoria/main/$SCRIPT_NAME" 

wget $SCRIPT_URL -O $SCRIPT_NAME
chmod +x $SCRIPT_NAME

HORA=$(whiptail --inputbox "Escolha a hora para executar o script diariamente (0-23):" 10 60 0 --title "Configuração do Cron" 3>&1 1>&2 2>&3)

CRON_JOB="$HORA 0 * * * /usr/local/bin/$SCRIPT_NAME"
(crontab -l; echo "$CRON_JOB") | crontab -

sudo mv $SCRIPT_NAME /usr/local/bin/

echo "Instalação concluída! O script será executado diariamente às $HORA:00."
