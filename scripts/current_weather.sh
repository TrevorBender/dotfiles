#!/bin/bash

script_dir=`dirname $0`

location=united-states/new-york/rochester-12763339

outfile=$script_dir/weather

conditions="UNKNOWN"
temp="UNKNOWN"

# Get weather page from yahoo
# and replace DEG with degree symbol
w3m -dump http://weather.yahoo.com/"$location" | sed 's/DEG/°/g' > $outfile

temp=`grep -A1 "Feels Like" $outfile | tail -1`
conditions=`grep -A1 "Current conditions" $outfile | tail -1`

echo \| $conditions \| $temp \|
