#! /usr/bin/env sh

day=$1
shift

odin run $day -out:out/out -collection:dependencies=dependencies $@
