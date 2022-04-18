#!/bin/bash

INPUT=EmployeeNames.csv
OLDIFS=$IFS
IFS=','
declare -a usernames=()
declare -a departments=()
echo ${#usernames[@]} #Number of elements in the array
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }

notExist() {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 1; done
  return 0
}

while read FirstName LastNmae Department
#FirstName LastNmae Department
do
    if [ "FirstName" = $FirstName ]; then
        continue
        # skip firstline having headers
    fi

    # echo "$FirstName and $LastNmae and $Department"

    # make username from first character of firstname and remaining last 7 characters of lastname
    username="${FirstName:0:1}${LastNmae:0:7}"

    username=${username,,} # make username lowercase
    if notExist $username ${usernames[@]}; then
        echo $username
        # echo "User does not exist"
        usernames+=($username)
        # usernames[${#usernames[@]}]=username
    # else
        # echo "User $username already exist"
    fi

    department="${Department}" # make Department lowercase
    if notExist $department ${departments[@]}; then
        echo "Department added ${department}"
        departments+=($department)
    # else
    #     echo "Department already exist ${department}"
    fi
done < $INPUT
IFS=$OLDIFS

echo "${#usernames[@]} Users added"
echo "Total ${#departments[@]} Department Groups added"
