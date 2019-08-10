#!/bin/sh
#
# Copyright (c) Microsoft Corporation. All rights reserved.
COMMIT=$1
QUALITY=$2
VSCODE_REMOTE_BIN=$3
SERVER_TAR_FILE_WIN=$4


# Check if this version is already installed
if [ ! -d "$VSCODE_REMOTE_BIN/$COMMIT" ]; then
	set -e
	# Check if 
	if [ -f /etc/alpine-release ]; then
		if [ "$QUALITY" = stable ]; then
			echo "Running the VSCode Server in Alpine WSL is currently only enabled on insider builds."
			exit 11
		fi
		if ! apk info | grep -qxe 'libstdc++'; then
			echo "libstdc++ is required to run the VSCode Server:"  1>&2
			echo "Please run \"su -c 'apk update && apk add libstdc++'\" from the Alpine WSL shell." 1>&2
			exit 12
		fi
	fi

	# This version does not exist
	if [ -d "$VSCODE_REMOTE_BIN" ]; then
		echo "Updating VS Code Server to version $COMMIT"

		# Remove the previous installations
		echo "Removing previous installation...";
		rm -rf "$VSCODE_REMOTE_BIN/????????????????????????????????????????"
		rm -rf "$VSCODE_REMOTE_BIN/????????????????????????????????????????-??????????"
		rm -rf "$VSCODE_REMOTE_BIN/????????????????????????????????????????-??????????.tar.gz"

	else
		echo "Installing VS Code Server $COMMIT"
	fi

	mkdir -p "$VSCODE_REMOTE_BIN"

	SERVER_TAR_FILE="~/code/vscode-server-linux-x64.tar.gz"

	# Unpack the .tar.gz file to a temporary folder name
	printf "Unpacking:   0%%";
	TMP_EXTRACT_FOLDER="$VSCODE_REMOTE_BIN/$COMMIT-$(date +%s)"
	mkdir "$TMP_EXTRACT_FOLDER"

	FILE_COUNT=$(tar -tf "$SERVER_TAR_FILE" | wc -l)
	P=0;
	tar -xf "$SERVER_TAR_FILE" -C "$TMP_EXTRACT_FOLDER" --strip-components 1 --verbose | { I=1; while read -r _; do I=$((I+1)); PREV_P=$P; P=$((100 * I / FILE_COUNT)); if [ "$PREV_P" -ne "$P" ]; then PRETTY_P="$P%"; printf "\b\b\b\b%4s" $PRETTY_P; fi; done; echo ""; }

	# Remove the .tar.gz file
	if [ $REMOVE_SERVER_TAR_FILE ]; then
		rm "$SERVER_TAR_FILE"
	fi

	# Rename temporary folder to final folder name, retries needed due to WSL
	for _ in 1 2 3 4 5; do
		mv "$TMP_EXTRACT_FOLDER" "$VSCODE_REMOTE_BIN/$COMMIT" && break
		sleep 2
	done

	if [ ! -d "$VSCODE_REMOTE_BIN/$COMMIT" ]; then
		echo "WARNING: Unable to move $TMP_EXTRACT_FOLDER. Trying copying instead." 1>&2
		cp -r "$TMP_EXTRACT_FOLDER" "$VSCODE_REMOTE_BIN/$COMMIT"
	fi

	if [ ! -d "$VSCODE_REMOTE_BIN/$COMMIT" ]; then
		echo "ERROR: Failed create $VSCODE_REMOTE_BIN/$COMMIT. Make sure all VSCode WSL windows are closed and try again." 1>&2
		exit 13
	fi
fi