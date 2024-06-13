#!/bin/bash

target=$1

mkdir report 
mkdir report/$target
mkdir report/$target/reports

mkdir report/$target/reports/aquatone

mkdir report/$target/reports/nmap
mkdir report/$target/reports/nmap/raw
mkdir report/$target/reports/nmap/summary 

mkdir report/$target/reports/gobuster 

mkdir report/$target/reports/gobuster/raw

mkdir report/$target/reports/gobuster/summary

mkdir report/$target/reports/dirsearch

mkdir report/$target/reports/crt