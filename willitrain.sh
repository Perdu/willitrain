#!/bin/bash

weather=$(wget -O - http://www.accuweather.com/fr/fr/villeurbanne/136558/daily-weather-forecast/136558?day=1 2>/dev/null | grep -A1 apgWxInfoObj.fc | grep -v apgWxInfoObj.fc)
precipitations=$(echo "$weather" | perl -pe "s/.*dp:{lp:'(\d+)'.*/\1/")
rain=$(echo "$weather" | perl -pe "s/.*dp:{lp:'\d+',r:'(\d+)'.*/\1/")
snow=$(echo "$weather" | perl -pe "s/.*dp:{lp:'\d+',r:'\d+',s:'(\d+)'.*/\1/")
ice=$(echo "$weather" | perl -pe "s/.*dp:{lp:'\d+',r:'\d+',s:'\d+',i:'(\d+)'.*/\1/")

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
