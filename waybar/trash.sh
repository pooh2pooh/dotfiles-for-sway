#!/bin/bash
trashN=$(trash-list | wc -l)
if [ $trashN -gt 0 ]; then
	echo "  $trashN"
else
	echo ""
fi
