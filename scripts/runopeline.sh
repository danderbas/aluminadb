runopeline () {
	#mysql --host localhost -uroot --database alumarv1 -e <(sed "s/^/\"/" $1| sed 's/\t/\",/' |sed 's/.*/call opline(&,2,0.02,3,48.88);/'|tr '\n' ' ')
	sed "s/^/\"/" $1| sed 's/\t/\",/' |sed 's/.*/call opline(&,2,0.02,3,48.88);/' > runsql

	mysql --host localhost -uroot alumarv1 < runsql | awk 'NR%2==0'
	#rm runsql
}

