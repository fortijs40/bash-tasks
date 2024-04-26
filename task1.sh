#!/bin/bash

city=$1
date=$2

echo $city
echo $date
api_key="youwishbuddy"
api_link="api.openweathermap.org/data/2.5/forecast?q=${city}&units=metric&lang=la&appid=${api_key}"

response=$(curl -s $api_link)

echo "$response" | jq -r '.list[] | "\(.dt_txt)\t Temp: \(.main.temp)°C\t Prognoze: \(.weather[].description)\t Ieteikums: \(if .weather[].description == "skaidrs laiks" then "sup" else "nah fam" end) "' | grep $date -A1

