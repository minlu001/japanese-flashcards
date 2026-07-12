#!/bin/bash

docker run --rm -v jp-flashcards_sqlite_data:/volume:ro -v /root/jp-flashcards:/backup alpine cp /volume/flashcards.db /backup/flashcards.db.bak
