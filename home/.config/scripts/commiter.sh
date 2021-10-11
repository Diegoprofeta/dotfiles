#!/usr/bin/env bash

github=/home/vitor/Downloads/github

repo0="dotfiles"
repo1="myarch"
repo2="ocean-dt"
repo3="common-tree"
repo4="vendor-ocean"
repo5="vendor-common"
repo6="kernel"
repo7="river-dt"
repo8="vendor-river"
repos="$repo0\n$repo1\n$repo2\n$repo3\n$repo4\n$repo5\n$repo6\n$repo7\n$repo8"

chosen="$(echo -e "$repos" | wofi --lines 12 --dmenu -p "  Commiter")"
case $chosen in
$repo0)
alacritty -t newcommit --working-directory $HOME/.dotfiles;;
$repo1)
alacritty -t newcommit --working-directory $github/myarch;;
$repo2)
alacritty -t newcommit --working-directory $github/ocean-dt;;
$repo3)
alacritty -t newcommit --working-directory $github/common-tree;;
$repo4)
alacritty -t newcommit --working-directory $github/vendor-ocean;;
$repo5)
alacritty -t newcommit --working-directory $github/vendor-common;;
$repo6)
alacritty -t newcommit --working-directory $github/kernel;;
$repo7)
alacritty -t newcommit --working-directory $github/river-dt;;
$repo8)
alacritty -t newcommit --working-directory $github/vendor-river;;

esac
exit 0;
