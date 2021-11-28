#!/bin/bash
declare -a st1=(8 7 6 5 4 3 2 1)
step=1

while true
do
    echo "1) ${st1[1]}"
    echo "2) ${st2[@]}"
    echo "3) ${st3[@]}"

    read -pr "Ход № $step (откуда, куда) (q - выход): " -a  inputNums
    echo ${inputNums[0]}
    if [ ${inputNum[0]} == 'q' ]
    then
        break
    fi

    # prefix=1
    # tst=st$prefix
    # echo "${!tst[@]}"
done