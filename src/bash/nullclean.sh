if [[ -e $1 ]]; then
	sed -i 's/\"NULL\"/NULL/gi' $1
	sed -i "s/\'NULL\'/NULL/gi" $1
fi
