$mysqlcommand -u$usrid --database $db < values_usuarios-clientes.mysql
$mysqlcommand -u$usrid --database $db < values_insumos.mysql
$mysqlcommand -u$usrid --database $db < values_insumos_pinturas.mysql
$mysqlcommand -u$usrid --database $db < values_insumos_contenedores_perfiles.mysql
$mysqlcommand -u$usrid --database $db < values_perfiles-matrices.mysql
$mysqlcommand -u$usrid --database $db < values_perfiles-matrices_nitruracion.mysql
$mysqlcommand -u$usrid --database $db < values_pedidos.mysql
$mysqlcommand -u$usrid --database $db < values_op_pintura.mysql

