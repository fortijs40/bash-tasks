#!/bin/bash

city=$1
date=$2

echo $city
echo $date
api_key="xxxxxxxxx"
api_link="api.openweathermap.org/data/2.5/forecast?q=${city}&units=metric&lang=la&appid=${api_key}"

response=$(curl -s $api_link)
if [ "$(echo "$response" | jq -r '.message')" = "city not found" ]; then
    echo "Šāda pilsēta netika atrasta"
    exit
fi

response=$(echo "$response" |\
jq -r '.list[] | "\(.dt_txt)\t Temp: \(.main.temp)°C\t Prognoze: \(.weather[].description)\t Ieteikums: \(
if .weather[].id >= 200 and .weather[].id <= 232
then
    "Paliec labāk telpās! Iet ārā ar lietussargu ir bīstami!"
elif .weather[].id >= 300 and .weather[].id <=321
then
    "Paņem lietussargu!"
elif .weather[].id >= 500 and .weather[].id <=531
then
    "Neaizmirsti paņemt lietusmēteli un gumijas zābakus!"
elif .weather[].id >= 600 and .weather[].id <=622
then
    "Uzvelc zābakus un saģērbies silti!"
elif .weather[].id == 800
then
    "Varēsi sauļoties vai lūkoties zvaigznēs"
elif .weather[].id >= 801 and .weather[].id <=804
then
    "Saulesbrilles vari atstāt mājās/Zvaigznes neredzēsi"
else
    "Esi uzmanīgs! Laikapstākļi nav skaidri!" end) "'| grep $date -A1 )

if [ -z "$response" ]; then
    echo "Laikapstākļu prognoze pieejama 5 dienām. Datumu ievadi YYYY-MM-DD formātā"
    exit
fi
echo "$response"
