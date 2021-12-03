#!/bin/bash

while getopts "d:n:" option
do
  case $option in
    n ) name="$OPTARG";;
    d ) dir_path="$OPTARG";;
  esac
done

arch=$(tar -cz $dir_path | base64)

echo "#!/bin/bash
arch=\"$arch\"
while getopts \"o:\" opt 
do
    case \$opt in
    o ) unpackdir="\$OPTARG";;
    esac
done
if [ \$unpackdir ]
then
    echo \"\$arch\" | base64 --decode | tar -xvz -C \$unpackdir
else
    echo \"\$arch\" | base64 --decode | tar -xvz 
fi" > $name.sh

chmod 755 $name.sh
