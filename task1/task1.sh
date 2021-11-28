#!/bin/bash

declare -a $inputNums
hit=0
miss=0
step=1

getPercent(){
    echo $(bc <<< "scale=2;($1)/($2) * 100")
}

while true
do
    echo "Step: $step"
    read -p "Please enter number from 0 to 9 (q - quit): " inputNum 
    
    if [ $inputNum == 'q' ]
    then
        break
    fi

    if ! [[ "$inputNum" =~ ^[0-9]$ ]]
    then
        echo "Invalid input data"
        continue
    fi

    rndNum=$((RANDOM%10))

    if [[ $inputNum != $rndNum ]]
    then
        echo "Miss! My number: $rndNum"
        miss=$((miss+1))
        inputNums+=($inputNum)
    else
        echo "Correct! My number: $rndNum"
        hit=$((hit+1))
        inputNums+=($inputNum+)
    fi

    if  [ ${#inputNums[@]} -gt 10 ]
    then
    echo is greater
        inputNums=(${inputNums[@]:1})
    else
    echo no
    fi

    resultsSum=$((hit + miss))
    step=$((step+1))
    hitPercent=$(getPercent $hit $resultsSum)
    missPercent=$(getPercent $miss $resultsSum)
    echo "Hit ${hitPercent}% Miss ${missPercent}%"
    echo "Numbers: ${inputNums[@]}"
done