#!/bin/bash

SCRIPT_NAME="limpa_memoria.sh"
SCRIPT_URL="https://raw.githubusercontent.com/theHenriqueFerreira/limpa_memoria/main/$SCRIPT_NAME"
CRON_SCRIPT_PATH="/usr/local/bin/$SCRIPT_NAME"

# Função para verificar se o script está instalado
check_installed() {
    if crontab -l | grep -q "$CRON_SCRIPT_PATH"; then
        return 0  # Já está instalado
    else
        return 1  # Não está instalado
    fi
}

# Baixa o script de limpeza
wget $SCRIPT_URL -O $SCRIPT_NAME
chmod +x $SCRIPT_NAME

if check_installed; then
    echo "O script já está instalado."
    UPDATE=$(whiptail --yesno "Deseja atualizar o script e escolher novas configurações para o cron?" 10 60 --title "Atualização" && echo "yes" || echo "no")

    if [ "$UPDATE" = "yes" ]; then
        echo "Atualizando o script..."
        sudo mv $SCRIPT_NAME $CRON_SCRIPT_PATH

        # Pergunta ao usuário qual hora deseja executar o cron job
        HORA=$(whiptail --inputbox "Escolha a hora (0-23) para executar o script diariamente:" 10 60 0 --title "Configuração do Cron" 3>&1 1>&2 2>&3)

        # Verifica se o usuário cancelou a entrada
        if [ $? -ne 0 ]; then
            echo "Atualização abortada pelo usuário."
            exit 1
        fi

        # Pergunta ao usuário quais minutos deseja executar o cron job
        MINUTOS=$(whiptail --inputbox "Escolha os minutos (0-59) para executar o script diariamente:" 10 60 0 --title "Configuração do Cron" 3>&1 1>&2 2>&3)

        # Verifica se o usuário cancelou a entrada
        if [ $? -ne 0 ]; then
            echo "Atualização abortada pelo usuário."
            exit 1
        fi

    else
        echo "Nenhuma alteração foi feita."
        exit 0
    fi
else
    # Pergunta ao usuário qual hora deseja executar o cron job
    HORA=$(whiptail --inputbox "Escolha a hora (0-23) para executar o script diariamente:" 10 60 0 --title "Configuração do Cron" 3>&1 1>&2 2>&3)

    # Verifica se o usuário cancelou a entrada
    if [ $? -ne 0 ]; then
        echo "Instalação abortada pelo usuário. Nenhum script foi instalado."
        exit 1
    fi

    # Pergunta ao usuário quais minutos deseja executar o cron job
    MINUTOS=$(whiptail --inputbox "Escolha os minutos (0-59) para executar o script diariamente:" 10 60 0 --title "Configuração do Cron" 3>&1 1>&2 2>&3)

    # Verifica se o usuário cancelou a entrada
    if [ $? -ne 0 ]; then
        echo "Instalação abortada pelo usuário. Nenhum script foi instalado."
        exit 1
    fi

    # Verifica se a hora e os minutos são válidos
    if ! [[ "$HORA" =~ ^[0-9]{1,2}$ ]] || [ "$HORA" -lt 0 ] || [ "$HORA" -gt 23 ]; then
        echo "Hora inválida. A instalação foi cancelada."
        exit 1
    fi

    if ! [[ "$MINUTOS" =~ ^[0-9]{1,2}$ ]] || [ "$MINUTOS" -lt 0 ] || [ "$MINUTOS" -gt 59 ]; then
        echo "Minutos inválidos. A instalação foi cancelada."
        exit 1
    fi

    # Cria a tarefa cron com a hora e minutos escolhidos
    CRON_JOB="$MINUTOS $HORA * * * $CRON_SCRIPT_PATH"
    (crontab -l | { cat; echo "$CRON_JOB"; } | crontab -)

    # Move o script para um diretório apropriado
    sudo mv $SCRIPT_NAME $CRON_SCRIPT_PATH

    echo "Instalação concluída! O script será executado diariamente às $HORA:$MINUTOS."
fi
