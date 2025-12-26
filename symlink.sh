#!/bin/sh
# symlinks milk-cursor to ~/.icons

# palette
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BOLD='\033[1m'
RESET='\033[0m'

SOURCE="$HOME/eudaimonia/milk-cursor"
TARGET="$HOME/.icons/milk-cursor"

printf "${CYAN}==> checking symlink status...${RESET}\n"

# check if target already exists and is a symlink
if [ -L "$TARGET" ]; then
    CURRENT_LINK=$(readlink "$TARGET")
    
    if [ "$CURRENT_LINK" = "$SOURCE" ]; then
        printf "${GREEN}✓ milk-cursor is already symlinked to ~/.icons${RESET}\n"
        exit 0
    else
        printf "${YELLOW}! symlink exists but points to different location${RESET}\n"
        printf "${YELLOW}  current: ${CURRENT_LINK}${RESET}\n"
        printf "${YELLOW}  expected: ${SOURCE}${RESET}\n"
        printf "${YELLOW}-> removing old symlink and creating new one...${RESET}\n"
        rm "$TARGET"
        if ln -s "$SOURCE" "$TARGET"; then
            printf "${GREEN}✓ successfully updated symlink${RESET}\n"
            exit 0
        else
            printf "${RED}✗ failed to create symlink${RESET}\n"
            exit 1
        fi
    fi
elif [ -e "$TARGET" ]; then
    printf "${RED}✗ ~/.icons/milk-cursor exists but is not a symlink${RESET}\n"
    exit 1
fi

# create .icons directory if it doesn't exist
if [ ! -d "$HOME/.icons" ]; then
    printf "${YELLOW}-> creating ~/.icons directory...${RESET}\n"
    mkdir -p "$HOME/.icons"
fi

# create symlink
printf "${YELLOW}-> symlinking milk-cursor to ~/.icons...${RESET}\n"
if ln -s "$SOURCE" "$TARGET"; then
    printf "${GREEN}✓ successfully symlinked milk-cursor to ~/.icons${RESET}\n"
else
    printf "${RED}✗ failed to create symlink${RESET}\n"
    exit 1
fi
