#!/bin/zsh

setopt extendedglob
repo-add packages.db.tar.zst container/home/builder/^go
mv container/home/builder/^go .
