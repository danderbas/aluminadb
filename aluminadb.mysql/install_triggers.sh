$mysqlcommand -u$usrid --database $db < triggers_op_extrusion.mysql
$mysqlcommand -u$usrid --database $db < triggers_op_pintura.mysql
$mysqlcommand -u$usrid --database $db < triggers_produccion_extrusion.mysql
$mysqlcommand -u$usrid --database $db < triggers_produccion_etiquetas.mysql
$mysqlcommand -u$usrid --database $db < triggers_produccion_perfiles.mysql

