#!/bin/bash

read -p "Enter Target Domain: " target

./setup.sh $target

./subdomains_and_directories.sh $target

./scanners.sh $target

./lookUp.sh $target