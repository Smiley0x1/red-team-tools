#!/bin/bash

target=$1

gobuster --timeout 20s --no-error -t 2000 dns -d "$target" -w /usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1million-110000.txt >> "report/$target/reports/gobuster/raw/subdomains"

grep -oE '[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' "report/$target/reports/gobuster/raw/subdomains" | sort | uniq > "report/$target/reports/gobuster/summary/subdomains"

cat "report/$target/reports/gobuster/summary/subdomains" | sudo /opt/aquatone --threads 20 -out "report/$target/reports/aquatone/subdomains"


gobuster --timeout 20s --no-error -t 2000 dir -u $target -w /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt >> "report/$target/reports/gobuster/raw/directories"

grep -oE 'https?://[^ ]+' "report/$target/reports/gobuster/raw/directories" | tr -d ']' >> "report/$target/reports/gobuster/summary/directories"

cat "report/$target/reports/gobuster/summary/directories" | sudo /opt/aquatone --threads 20 -out "report/$target/reports/aquatone/directorySnapshots"