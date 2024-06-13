#!/bin/bash

target=$1

file="${target}_LookupResults.txt"

echo "NSLOOKUP" > "$file"
nslookup "$target" >> "$file"
echo "" >> "$file"

echo "WHOIS" >> "$file"
whois "$target" >> "$file"
echo "" >> "$file"

echo "DIG" >> "$file"
dig "$target" >> "$file"
echo "" >> "$file"

