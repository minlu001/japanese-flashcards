#!/bin/bash

docker run --rm -v japanese-flashcards_sqlite_data:/volume:ro -v /root/japanese-flashcards:/backup alpine cp /volume/flashcards.db /backup/flashcards.db.bak
