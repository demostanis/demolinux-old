#!/bin/sh

rm *.pkg.tar.*
repo-add packages.db.tar.zst container/home/builder/*
mv container/home/builder/* .
