 #!/bin/bash
echo

validate(){
local num="$1"
# error for input : 7b78, uhdg, 778u,...
if [[ ! "$num" =~ ^[0-9]{4}$ ]];then
echo "Error: Input must be digit only"
exit 1
fi
#error for all same digit : 1111, 2222,..
if [[ "$num" =~ ^([0-9])\1{3}$ ]]; then
echo "Error: all digits must not be same"
exit 1
fi
echo

}

kaprekar(){

local num=$1
local count=0
local kap_const=6174

while [[ $num -ne $kap_const ]]; do
count=$((count+1))
num=$(printf "%4d" $num)

#sort in desc order
num_desc=$(echo $num | grep -o . | sort -r | tr -d '\n')

#sort in asc order
num_asc=$(echo $num | grep -o . | sort | tr -d '\n')

#next num calculate but here 
# 10#num --> to tell bash numbers with leading zero 
# e.g (0123, 0836,...) are not octal but decimal only
num=$((10#$num_desc - 10#$num_asc))
num=$(printf "%4d" $num)

# input like : 5556, 8887,.... gives infinite loop : terminate such loops
if [[ "$num" -eq 0 ]]; then
echo "Iteration $count: $num_desc - $num_asc = $num"
echo "Kaprekae routine cannot proceed futher as the result is 0."
return
fi
# print iteration number and calculations
echo "Iteration $count: $num_desc - $num_asc = $num"
done

echo
echo "Kaprekars routine took $count iterations to reach $kap_const"
echo

}

#input of length 4 by default
read -n 4  -p "Enter a 4 digit number:" input
echo
validate "$input"
kaprekar "$input"
