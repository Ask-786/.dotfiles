#!/bin/bash

# Directory to save downloaded images
DOWNLOAD_DIR="$HOME/Pictures/Wallpapers/Unsplash"

# Maximum number of wallpapers to keep
MAX_WALLPAPERS=5

IMAGE_URL=$(
	curl "https://source.unsplash.com/random/1920x1080/?wallpaper,tech,laptop,gadgets,nature,street,nature,cars,black,dark,bikes,motorcycles,formulaone,formula1,motogp" |
		grep -o 'href="[^"]*"' |
		cut -d'"' -f2
)

# Download a random image
IMAGE_FILE="$DOWNLOAD_DIR/$(date +%s)_wallpaper.jpg"
curl -o "$IMAGE_FILE" "$IMAGE_URL"

# Set the downloaded image as wallpaper using swaymsg
swaymsg output '*' bg "$IMAGE_FILE" fill

# Delete the oldest wallpaper if the number of wallpapers exceeds the limit
WALLPAPERS_COUNT=$(ls -1 "$DOWNLOAD_DIR" | grep "_wallpaper.jpg" | wc -l)
if [ "$WALLPAPERS_COUNT" -gt "$MAX_WALLPAPERS" ]; then
	OLDEST_WALLPAPER=$(ls -1t "$DOWNLOAD_DIR" | grep "_wallpaper.jpg" | tail -n 1)
	rm "$DOWNLOAD_DIR/$OLDEST_WALLPAPER"
fi
