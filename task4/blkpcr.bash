#!/bin/bash
declare -a pids
completed=0
toDo=0

trap "echo completed: $completed" SIGUSR1
trap "echo toDo: $toDo" SIGUSR2

get_abs_filename() {
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

while getopts "d:e:c:n:" option
do
  case $option in
    e ) mask="$OPTARG";;
    d ) dirpath="$OPTARG";;
    c ) command="$OPTARG";;
    n ) number="$OPTARG";;
  esac
done

files=($dirpath/$mask)
toDo=${#files[@]}

for file in ${files[@]}
do
  rndNum=$((RANDOM%100))

  if (( ${#pids[@]} >= $number ))
  then
    wait -n ${pids[@]}
  fi
    # ($command $(get_abs_filename $file);completed=$((completed + 1));toDo=$((toDo - 1))) &
    (sleep $rndNum;echo $(get_abs_filename $file);completed=$((completed + 1));toDo=$((toDo - 1));) &
    pids+=($!)
  
done

for pid in ${pids[@]}; do
    wait $pid
done