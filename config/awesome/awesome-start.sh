#!/bin/sh

MEM_TOTAL=$(free -m | grep Mem: | awk '{print $2}')

function mem_free ()
{
    local mem_free=$(free -m | grep Mem: | awk '{print $4}')
    echo "$mem_free/${MEM_TOTAL}MB"
}

function power ()
{
    local dir=/sys/class/power_supply/BAT0
    local capacity=$(cat $dir/capacity)
    local status=$(cat $dir/status)
    echo "[$capacity $status]"
}

function sound ()
{
    local vol=$(amixer -c 1 get Master | grep Mono: | awk '{print $4}')
    local mute=$(amixer -c 1 get Master | grep Mono: | awk '{print $6}')
    local mutestr
    if [[ $mute = "on" ]] ; then
        mutestr=" "
    else
        mutestr="X"
    fi
    echo "$vol$mute"
}

function show_status ()
{
    local uptime_string=$(uptime | sed  's/.*://; s/,//g')
    local mem_info=$(mem_free)
    local power_info=$(power)
    local sound_info=$(sound)
    #local notification=$(shownot)
    echo "mystatus:set_text(\"$sound_info $power_info [$mem_info$uptime_string] \")" | awesome-client
}

while true ; do
    show_status
    sleep 5;
done &
STATUS_PID=$?

#xsetroot -solid "#fdf6e3"
#feh --bg-scale /opt/backup/storage/backup/desktop\ pics/nature.jpg

# start awesome
mkdir -p ~/.cache/awesome
MSG="AWESOME START $(date)"
echo "$MSG" >> ~/.cache/awesome/stdout 
echo "$MSG" >> ~/.cache/awesome/stderr 
awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr || break

kill -9 ${STATUS_PID}
#kill -9 ${MPD_STATUS_PID}
