#!/bin/bash

USER_AGENT='Mozilla/5.0 Firefox/60.0'
COOKIE='ak_bmsc=6A2A5258000604887A6528CF3E4BEFEE02112B7C26120000509AAB5B0C06CA14~pljQMEaiT1asu9euTiOOmnhngXrCCebLgGngcWafllqoG6H+V65DVJFTt01gVPtI9kkgReUme5GdFqDbKzC/OAjRQHs0ixkpZogr4760fVWu0xycEK0WF0RaC4wRTlqHBGdxPcsyjQM/GKJN00g69kQFHlKqicRCfJ/+g9qEb/f28rjTHrlPk7tV0dmIJe8s6z+Ze/1cIVsRBXatX3O/YOEjKHZc5Gxu6PAs5JtaP0kjq8h+AwLK8ntyHG6soQYDIM;'
weather=$(wget -O - --header "Cookie: $COOKIE" -U "$USER_AGENT" http://www.accuweather.com/fr/fr/villeurbanne/136558/daily-weather-forecast/136558?day=1 2>/dev/null)
precipitations=$(echo "$weather" | grep -m1 'cipitations:' | perl -pe "s/.*>(\d+) mm.*/\1/")
rain=$(echo "$weather" | grep -m1 'Pluie:' | perl -pe "s/.*>(\d+) mm.*/\1/")
snow=$(echo "$weather" | grep -m1 Neige | perl -pe "s/.*>((\d*.)?\d+) cm.*/\1/")
ice=$(echo "$weather" | grep -m1 Verglas | perl -pe "s/.*>((\d*.)?\d+) mm.*/\1/")

if [ "$precipitations" -gt 0 ]
then
    echo "Précipitations : $precipitations mm"
fi

if [ "$rain" -gt 0 ]
then
    echo "Pluie : $rain mm"
fi

if [ "$snow" != "0" ]
then
    echo "Neige : $snow cm"
fi

if [ "$ice" != "0" ]
then
    echo "Verglas : $ice mm"
fi

if [ "$precipitations" -gt 0 -o "$rain" -gt 0 -o "$snow" != "0" -o "$ice" -gt 0 ]
then
    echo 'https://www.google.fr/search?q=météo'
fi
