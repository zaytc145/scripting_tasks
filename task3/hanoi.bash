#!/bin/bash
declare -a result=(8 7 6 5 4 3 2 1)
declare -a st_1=(${result[@]})
declare -a st_2 st_3
# eval "echo \${st_$num[1]}"
errorMessage="Неверный ход! Повторите!"
stecksCount=3
step=1
while true
do
    echo "1) ${st_1[@]}"
    echo "2) ${st_2[@]}"
    echo "3) ${st_3[@]}"

    if [[ ${st_3[*]} == ${result[*]} ]]
    then
        break
    fi

    read -p "Ход № $step (откуда, куда) (q - выход): " -a  inputNums
    
    if [[ ${inputNums[0]} == "q" ]]
    then
        break
    fi

    inputNumsCount=${#inputNums[@]}

    if [[ ${inputNumsCount} != 2 ]]
    then
        echo "$errorMessage"
        continue
    fi

    start=${inputNums[0]}
    target=${inputNums[1]}

    if  ((${inputNums[0]} > $stecksCount)) || ((${inputNums[1]} > $stecksCount ))
    then
        echo "$errorMessage"
        continue
    fi

    eval "startValue=\${st_$start[@]: -1}"
    eval "endValue=\${st_$target[@]: -1}"

    if  [[ -z "$startValue" ]]
    then
        echo "$errorMessage"
        continue
    fi

    if  [[ ! -z "$endValue" ]] && [[ $startValue > $endValue ]]
    then
        echo "$errorMessage"
        continue
    fi

    eval "st_$target+=(\${st_$start[@]: -1})"
    eval "unset st_$start[-1]"

    step=$((step+1))
done