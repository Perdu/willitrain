#!/bin/bash

weather=$(wget -O - http://www.accuweather.com/fr/fr/villeurbanne/136558/daily-weather-forecast/136558?day=1 2>/dev/null)
precipitations=$(echo "$weather" | grep -m1 'cipitations:' | perl -pe "s/.*>(\d+) mm.*/\1/")
rain=$(echo "$weather" | grep -m1 Pluie | perl -pe "s/.*>(\d+) mm.*/\1/")
snow=$(echo "$weather" | grep -m1 Neige | perl -pe "s/.*>(\d+) cm.*/\1/")
ice=$(echo "$weather" | grep -m1 Verglas | perl -pe "s/.*>(\d+) mm.*/\1/")

if [ "$precipitations" -gt 0 ]
then
    echo "Précipitations : $precipitations mm"
fi

if [ "$rain" -gt 0 ]
then
    echo "Pluie : $rain mm"
fi

if [ "$snow" -gt 0 ]
then
    echo "Neige : $snow cm"
fi

if [ "$ice" -gt 0 ]
then
    echo "Verglas : $ice mm"
fi
