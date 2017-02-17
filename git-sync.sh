#!/bin/bash
cd "$(dirname "$0")"
git add --all .
git commit -am "automatic log update `date +\%Y-\%m-\%d---\%H:\%M:\%S"
git push origin master
