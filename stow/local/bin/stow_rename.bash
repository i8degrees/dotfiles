#!/bin/bash

# Script to migrate Stow dotfiles from ~/dotfiles.git to ~/.dotfiles and update symlinks
# Assumes:
# - All subdirectories in ~/dotfiles.git are Stow packages.
# - All packages are currently stowed into ~/.
# - ~/.dotfiles does not already exist.
# - Run this from anywhere, but ensure you have permissions.

set -e  # Exit on error

OLD_STOWDIR="$1"
if [ -z "$OLD_STOWDIR" ]; then
  OLD_STOWDIR="$HOME/dotfiles.git"
fi

#NEW_STOWDIR="$HOME/.dotfiles"
NEW_STOWDIR="$2"
if [ -z "$NEW_STOWDIR" ]; then
  NEW_STOWDIR="$HOME/.dotfiles"
fi

TARGET="$HOME"

# Check if old stowdir exists
if [ ! -d "$OLD_STOWDIR" ]; then
  echo "Error: $OLD_STOWDIR does not exist."
  exit 1
fi

# Check if new stowdir already exists
if [ -d "$NEW_STOWDIR" ]; then
  echo "Error: $NEW_STOWDIR already exists. Please remove or rename it first."
  exit 1
fi

# Get list of packages (subdirectories)
cd "$OLD_STOWDIR"
PACKAGES=$(ls -d */ | sed 's|/||')  # Get dir names without trailing /

# Unstow all packages
for pkg in $PACKAGES; do
  stow -D -t "$TARGET" "$pkg"
  echo "Unstowed package: $pkg"
done

# Move the stow directory
cd ..
mv "$OLD_STOWDIR" "$NEW_STOWDIR"
echo "Moved $OLD_STOWDIR to $NEW_STOWDIR"

# Restow all packages from new location
cd "$NEW_STOWDIR"
for pkg in $PACKAGES; do
  stow -t "$TARGET" "$pkg"
  echo "Stowed package: $pkg"
done

echo "Migration complete. All symlinks should now point to the new location."
