#!/bin/bash

function criarUsuario(){
    #Criar usuários em um grupo padrão. O grupo dever ser o primeiro argumento.
    #Função deve receber no mínimo 2 argumentos: Grupo e nome do usuário.
    
    [ $# -lt 2 ] && exit -1
    
    nomes=($@)
    for nome in ${nomes[@]:1};do
        useradd ${nome} -m -s /bin/bash -p $(openssl passwd -6 Senha123) -G $1
    done
}

echo "Criando diretórios..."

mkdir /publico
mkdir /adm
mkdir /ven
mkdir /sec

echo "Criando grupos de usuários..."

groupadd GRP_ADM
groupadd GRP_VEN
groupadd GRP_SEC

echo "Criando usuários..."

usuarios_adm=("GRP_ADM" "carlos" "maria" "joao")
criarUsuario ${usuarios_adm[@]}

usuarios_ven=("GRP_VEN" "debora" "sebastiana" "roberto")
criarUsuario ${usuarios_ven[@]}

usuarios_sec=("GRP_SEC" "josefina" "amanda" "rogerio")
criarUsuario ${usuarios_sec[@]}

echo "Especificando permissões dos diretórios...."

chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

chmod 770 /adm
chmod 770 /ven
chmod 770 /sec
chmod 777 /publico

echo "Fim....."
