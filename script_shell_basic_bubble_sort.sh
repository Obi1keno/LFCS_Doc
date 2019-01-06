#!/bin/bash
#The backslash before the angle bracket is there because the bracket needs
#to be escaped to be interpreted correctly.

array=( linux tutorial blog )
swaps=1
while (( swaps > 0 )); do

swaps=0
for (( i=0; i < (( ${#array[@]} – 1 )) ; i++ )); do
if [ “${array[$i]}” > “${array[$(( i + 1 ))]}” ]; then # Here is the sorting condition
tempstring=${array[$i]}
array[$i]=${array[$(( i + 1 ))]}
array[$(( i + 1 ))]=$tempstring
(( swaps=swaps + 1 ))
fi
done
done
echo ${array[@]} # Returns “blog linux tutorial”
