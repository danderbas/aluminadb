hostname="localhost"
usrid="alumar"
passw="4lum4r"
db="alumarv4"

# personal (hay una tabla)
# insumos
# insumos tocho0
	#DROP TABLE IF EXISTS stock_tochos;
	#DROP TABLE IF EXISTS tocho0;
	#DROP TABLE IF EXISTS cargas_aluminio_packinglist;
	#DROP TABLE IF EXISTS cargas_aluminio;
mysql -u$usrid -p$passw --database $db < loadvalues_perfiles-matrices.mysql
# nitruracion
	#	medicion dureza
	# correcciones de matrices
mysql -u$usrid -p$passw --database $db < loadvalues_pedidos.mysql
mysql -u$usrid -p$passw --database $db < loadvalues_op_extrusion.mysql
mysql -u$usrid -p$passw --database $db < loadvalues_op_pintura.mysql
#cortetochos
#extrusion
#envejecimiento
#pintura
#stock_perfiles
