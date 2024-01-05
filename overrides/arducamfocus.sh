#!/bin/bash

VALUE=$(v4l2-ctl -C focus_absolute -d /dev/v4l-subdev1)
VALUE=${VALUE:16:4}

case $1 in
        [i])    if [[ $VALUE -lt 4046 ]]; then
                        ((VALUE=VALUE + 50))
                        v4l2-ctl -c focus_absolute=$VALUE -d /dev/v4l-subdev1
                fi
                ;;

        [d])    if [[ $VALUE -gt -1 ]]; then
                        ((VALUE=VALUE - 50))
                        v4l2-ctl -c focus_absolute=$VALUE -d /dev/v4l-subdev1
                fi
                ;;

        [v])    if [[ $2 -lt 4096 ]] && [[ $2 -gt -1 ]]; then
                        VALUE=$2
                        v4l2-ctl -c focus_absolute=$VALUE -d /dev/v4l-subdev1
                fi
                ;;

        [f])            echo $VALUE
			exit
                ;;

        *)      echo "Arducam 16MP IMX519 manual focus script by AmfKuna#5125"
                echo
                echo "Usage: arducamfocu.sh i|d|v 0-4095"
                echo "i - increment 50, d - decrement 50, v - 0-4095, f - return only value"
                ;;
esac

echo Focus "$VALUE"

