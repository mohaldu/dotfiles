#!/usr/bin/env bash
# set screenshots to downloads
defaults write com.apple.screencapture location -string "${HOME}/Downloads"
defaults write com.apple.screencapture type -string "png"

# finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowStatusBar -bool true

# dock

# hide recent apps
defaults write com.apple.dock show-recents -bool false
