# md5hashcrack

O script feito de forma bem rudimentar, não tem enfeites e luzinhas piscando no terminal, mas ele pode quebrar um hash MD5, caso você passe uma wordlist completa que, possivelmenter possa ter a palavra chave.

‘Então esse script não consegue quebrar uma hash com certeza?’
Não, assim como aquelas ferramentas super robustas que existem por aí, esse script não consegue quebrar um hash com toda certeza. Para uma ferramenta de bruteforce obter secusso, depende sempre de passar argumentos(wordlist) que, por sorte, esteja a sua palavra chave nela. A ferramente te ajuda em não ter que fazer isso na mão.

Abaixo, deixo o código fonte do script para que vocês possam dar uma olhada e utilizar.

```
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
```
