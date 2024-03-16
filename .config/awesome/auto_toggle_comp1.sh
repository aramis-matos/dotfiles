#! /bin/bash



while true; do
isLaunchers=$(pidof steam wineserver)
ispicomon=$(pidof picom)
	if [ "$isLaunchers" != "" ] && [ "$ispicomon" != "" ]; then
		echo "$isLaunchers" "$ispicomon"
		kill "$ispicomon"
	elif [ "$isLaunchers" == "" ] && [ "$ispicomon" == "" ]; then
		picom --experimental-backends &
	fi
	sleep 5
done
