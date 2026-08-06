if [[ $1 != "" ]]; then
	lpath="alumina"
else
	lpath="aluminalocal"
fi

# functions
mysql --login-path=$lpath $alumardb -vv < functions.mysql
mysql --login-path=$lpath $alumardb -vv < functions_check.mysql

# tables
mysql --login-path=$lpath $alumardb -vv < tables_usuarios-clientes.mysql
mysql --login-path=$lpath $alumardb -vv < tables_insumos.mysql
mysql --login-path=$lpath $alumardb -vv < tables_insumos_tochos.mysql
mysql --login-path=$lpath $alumardb -vv < tables_insumos_pinturas.mysql
mysql --login-path=$lpath $alumardb -vv < tables_insumos_contenedores_perfiles.mysql
mysql --login-path=$lpath $alumardb -vv < tables_perfiles-matrices.mysql
mysql --login-path=$lpath $alumardb -vv < tables_pedidos.mysql
mysql --login-path=$lpath $alumardb -vv < tables_op_extrusion.mysql
mysql --login-path=$lpath $alumardb -vv < tables_op_pintura.mysql
mysql --login-path=$lpath $alumardb -vv < tables_produccion_cortetochos.mysql
mysql --login-path=$lpath $alumardb -vv < tables_produccion_extrusion.mysql
mysql --login-path=$lpath $alumardb -vv < tables_produccion_tochos.mysql
mysql --login-path=$lpath $alumardb -vv < tables_produccion_envejecimiento.mysql
mysql --login-path=$lpath $alumardb -vv < tables_produccion_pinturas.mysql
mysql --login-path=$lpath $alumardb -vv < tables_produccion_pretratamiento.mysql
mysql --login-path=$lpath $alumardb -vv < tables_produccion_pintura.mysql
#mysql --login-path=$lpath $alumardb < tables_produccion_etiquetas.mysql
mysql --login-path=$lpath $alumardb -vv < tables_produccion_perfiles.mysql
mysql --login-path=$lpath $alumardb -vv < tables_produccion_controlcalidad.mysql

mysql --login-path=$lpath $alumardb -vv < tables_productos.mysql

# triggers
mysql --login-path=$lpath $alumardb -vv < triggers_op_extrusion.mysql
mysql --login-path=$lpath $alumardb -vv < triggers_op_pintura.mysql
mysql --login-path=$lpath $alumardb -vv < triggers_produccion_tochos.mysql
mysql --login-path=$lpath $alumardb -vv < triggers_produccion_pinturas.mysql
mysql --login-path=$lpath $alumardb -vv < triggers_produccion_extrusion.mysql
mysql --login-path=$lpath $alumardb -vv < triggers_produccion_envejecimiento.mysql
mysql --login-path=$lpath $alumardb -vv < triggers_produccion_pintura.mysql
#mysql --login-path=$lpath $alumardb -vv < triggers_produccion_etiquetas.mysql
mysql --login-path=$lpath $alumardb -vv < triggers_produccion_perfiles.mysql
mysql --login-path=$lpath $alumardb -vv < triggers_info.mysql

# values
mysql --login-path=$lpath $alumardb -vv < values_usuarios-clientes.mysql
mysql --login-path=$lpath $alumardb -vv < values_insumos.mysql
mysql --login-path=$lpath $alumardb -vv < values_insumos_pinturas.mysql
mysql --login-path=$lpath $alumardb -vv < values_insumos_contenedores_perfiles.mysql
mysql --login-path=$lpath $alumardb -vv < values_perfiles-matrices.mysql
mysql --login-path=$lpath $alumardb -vv < values_perfiles-matrices_nitruracion.mysql
mysql --login-path=$lpath $alumardb -vv < values_pedidos.mysql
mysql --login-path=$lpath $alumardb -vv < values_op_pintura.mysql

# views
mysql --login-path=$lpath $alumardb -vv < views_insumos_pinturas.mysql
mysql --login-path=$lpath $alumardb -vv < views_extrusion.mysql
mysql --login-path=$lpath $alumardb -vv < views_matrices.mysql
mysql --login-path=$lpath $alumardb -vv < views_pedidos.mysql

# procedures
mysql --login-path=$lpath $alumardb -vv < procedures_matrices_info.mysql

