#! /bin/bash

tr '[:space:][:punct:]' '\n' < ./data/spelling_success.txt |
  tr '[:upper:]' '[:lower:]' |
    sort -u |
      comm -23 - /usr/share/dict/words
