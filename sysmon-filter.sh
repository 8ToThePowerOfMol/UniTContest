#!/bin.bash

echo "UtcTime;ProcessId;Image;User;Protocol;Initiated;SourceIp;SourceHostname;SourcePort;SourcePortName;DestinationIp;DestinationHostname;DestinationPort" \
> "$1_networkconnections.csv"

cat $1 \
| grep -E "\"Network connection detected:|UtcTime:|ProcessId:|Image:|User:|Protocol:|Initiated:|SourceIp:|SourceHostname:|SourcePort:|SourcePortName:|DestinationIp:|DestinationHostname:|DestinationPort:" \
| grep -E "\"Network connection detected:" -A 13 \
| sed '/\"Network connection detected:/d' \
| grep -E -o "\:(.*)" \
| sed 's/\: //g' \
| awk '{if(NR%13==0) print $0; else printf "%s;", $0;}' \
| sed 's/\n;/;/g' \
>> "$1_networkconnections.csv"