if [[ -e $1 ]]; then
	sed -i 's/\"NULL\"/NULL/g' $1
	sed -i "s/\'NULL\'/NULL/g" $1
fi
