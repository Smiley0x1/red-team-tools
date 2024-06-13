#!/bin/bash 
echo "WARNING"
echo "Subdomains will not return any certs when ran through here"
DOMAIN=$1

DIRSEARCHPATH="/home/smiley/Tools/dirsearch-master"
DIRECTORY="${DOMAIN}_recon"
mkdir $DIRECTORY

nmap_scan(){


	for domain in $(cat report/$DOMAIN/reports/gobuster/summary/subdomains)
	do
	  # Check if the domain is not empty
	  if [[ ! -z "$domain" ]]; then
	    echo "Scanning domain: $domain"
	    formatted_domain=$(echo "$domain" | tr '/' '_')
	    cleaned_domain=$(echo "$domain" | sed -e 's#^http://##' -e 's#^https://##')

		nmap -sV "$cleaned_domain" > report/$DOMAIN/reports/nmap/raw/${formatted_domain}_scan.txt
		echo "Services" > "report/$DOMAIN/reports/nmap/summary/${formatted_domain}_scan.txt"
		echo "" >> "report/$DOMAIN/reports/nmap/summary/${formatted_domain}_scan.txt"
		grep -E "^\S+\s+\S+\s+\S+$" report/$DOMAIN/reports/nmap/raw/${formatted_domain}_scan.txt >> "report/$DOMAIN/reports/nmap/summary/${formatted_domain}_scan.txt"
		echo "" >> "report/$DOMAIN/reports/nmap/summary/${formatted_domain}_scan.txt"
		echo "Ports" >> "report/$DOMAIN/reports/nmap/summary/${formatted_domain}_scan.txt"
		echo "" >> "report/$DOMAIN/reports/nmap/summary/${formatted_domain}_scan.txt"
		grep -Eo '^[0-9]+/[^ ]+' report/$DOMAIN/reports/nmap/raw/${formatted_domain}_scan.txt >> "report/$DOMAIN/reports/nmap/summary/${formatted_domain}_scan.txt"
	fi
done
}

dirsearch_scan(){
	for domain in $(cat report/$DOMAIN/reports/gobuster/summary/subdomains)
	do
	  # Check if the domain is not empty
	  if [[ ! -z "$domain" ]]; then
	    echo "Scanning domain: $domain"
	    formatted_domain=$(echo "$domain" | tr '/' '_')
	    cleaned_domain=$(echo "$domain" | sed -e 's#^http://##' -e 's#^https://##')

		python3 $DIRSEARCHPATH/dirsearch.py -u $cleaned_domain -e php -q -o report/$DOMAIN/reports/dirsearch/${formatted_domain}
fi
done
}

crt_scan() {
 curl "https://crt.sh/?q=${DOMAIN}&output=json" -o report/$DOMAIN/reports/crt
 jq -r ".[] | .name_value" $DIRECTORY/crt_dirty >> report/$DOMAIN/reports/crt
}

nmap_scan
dirsearch_scan
crt_scan                                                                                                                      
