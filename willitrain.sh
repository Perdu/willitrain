#!/bin/bash

source ./location_config.sh

#USER_AGENT='Mozilla/5.0 Firefox/60.0'
weather=$(wget -O - "https://weather.com/fr-FR/temps/aujour/l/$location?par=google" 2>/dev/null)
precipitations=$(echo "$weather" | grep -oPm4 "precip--3JCDO\">\d+%</span>" | perl -pe "s/.*>(\d+)%<.*/\1/")
rain=0 #$(echo "$weather" | grep -m1 'Pluie:' | perl -pe "s/.*>(\d+) mm.*/\1/")
snow="0" #$(echo "$weather" | grep -m1 Neige | perl -pe "s/.*>((\d*.)?\d+) cm.*/\1/")
ice="0" #$(echo "$weather" | grep -m1 Verglas | perl -pe "s/.*>((\d*.)?\d+) mm.*/\1/")

max=0
for p in $precipitations
do
    if [ "$p" -gt "$max" ]
    then
        max=$p
    fi
done

if [ "$max" -gt 0 ]
then
    echo "Précipitations : $max%"
fi

#if [ "$rain" -gt 0 ]
#then
#    echo "Pluie : $rain mm"
#fi

#if [ "$snow" != "0" ]
#then
#    echo "Neige : $snow cm"
#fi

#if [ "$ice" != "0" ]
#then
#    echo "Verglas : $ice mm"
#fi

if [ "$max" -gt 0 -o "$rain" -gt 0 -o "$snow" != "0" -o "$ice" -gt 0 ]
then
    echo 'https://www.google.fr/search?q=météo'
fi
