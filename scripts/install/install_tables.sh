$mysqlcommand -u$usrid --database $db < tables_usuarios-clientes.mysql
$mysqlcommand -u$usrid --database $db < tables_insumos.mysql
$mysqlcommand -u$usrid --database $db < tables_insumos_tochos.mysql
$mysqlcommand -u$usrid --database $db < tables_insumos_pinturas.mysql
$mysqlcommand -u$usrid --database $db < tables_insumos_contenedores_perfiles.mysql
$mysqlcommand -u$usrid --database $db < tables_perfiles-matrices.mysql
$mysqlcommand -u$usrid --database $db < tables_perfiles-matrices_nitruracion.mysql
$mysqlcommand -u$usrid --database $db < tables_pedidos.mysql
$mysqlcommand -u$usrid --database $db < tables_op_extrusion.mysql
$mysqlcommand -u$usrid --database $db < tables_op_pintura.mysql
$mysqlcommand -u$usrid --database $db < tables_produccion_cortetochos.mysql
$mysqlcommand -u$usrid --database $db < tables_produccion_extrusion.mysql
$mysqlcommand -u$usrid --database $db < tables_produccion_envejecimiento.mysql
$mysqlcommand -u$usrid --database $db < tables_produccion_pintura.mysql
$mysqlcommand -u$usrid --database $db < tables_produccion_etiquetas.mysql
$mysqlcommand -u$usrid --database $db < tables_produccion_perfiles.mysql

