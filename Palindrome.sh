#!/bin/bash
read -p "Enter String: " string
if [[ $(rev <<< "$string") == "$string" ]]
#We can you below logic as well
#if [[ "$(echo "$string" | rev)" == "$string" ]]
then
echo "palindrome"
else
echo "not a palindrome"
fi