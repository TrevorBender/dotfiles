#!/bin/bash

script_dir=`dirname $0`

location=united-states/new-york/rochester-12763339

weather_file=$script_dir/weather

w3m -dump http://weather.yahoo.com/"$location" | sed 's/DEG/°/g' > $weather_file

# Get current conditions from weather file
cnd=`grep -A1 "Current conditions" $weather_file | tail -1`

if echo $cnd | grep -E -i -q 'partly cloudy' ; then
	echo 'c'
elif echo $cnd | grep -E -i -q 'fair|sunny' ; then
	echo 'A'
elif echo $cnd | grep -E -i -q 'cloudy' ; then
	echo 'e'
elif echo $cnd | grep -E -i -q 'storm|thunder' ; then
	echo 'i'
elif echo $cnd | grep -E -i -q 'snow' ; then
	echo 'k'
elif echo $cnd | grep -E -i -q 'rain' ; then
	echo 'h'
elif echo $cnd | grep -E -i -q 'shower' ; then
	echo 'g'
fi


