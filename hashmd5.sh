#!/bin/bash/
  
if [ -z "$1" ]; then
    echo "Não foi passado uma wordlist."                            #obrigatorio a passagem do argumento wordlist.
else
    echo "Hash: "
    read hashcrack                                                  #aqui ele pega a hash para ser quebrada.
    declare -a comp=()
    for i in $(cat $1)
    do 
        comp+=( $i )
        echo $i | md5sum | tr -d '-' | tr -d ' '  >>databasehash    #cria uma base da dados de hash
    done;

    (( cont = 0 ))
    for x in $(cat databasehash)                                    
    do
        for z in ${comp[$cont]}
        do  
            if [[ $x == "$hashcrack" ]]; then
                echo "achou: $x, a palavra chave é $z"
                exit;
            else
                (( cont = $cont + 1 ));
                if [ $cont > $(wc -l $1 | tr -d 'nomes' | tr -d ' ') ] ; then
                    echo "Não encontrou"
                    clear
                    break;
                fi 
            fi;
        done;
    done;
    rm databasehash
fi;




