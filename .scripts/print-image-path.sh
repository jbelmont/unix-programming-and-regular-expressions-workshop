#! /bin/bash

printf "![%s](../%s)" $(pbpaste | sed 's/\.png//g') $(pbpaste) | pbcopy