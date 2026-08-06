$mysqlcommand -u$usrid --database $db < "$sqlroot/values/values_usuarios-clientes.mysql"
$mysqlcommand -u$usrid --database $db < "$sqlroot/values/values_insumos.mysql"
$mysqlcommand -u$usrid --database $db < "$sqlroot/values/values_insumos_pinturas.mysql"
$mysqlcommand -u$usrid --database $db < "$sqlroot/values/values_insumos_contenedores_perfiles.mysql"
$mysqlcommand -u$usrid --database $db < "$sqlroot/values/values_perfiles-matrices.mysql"
$mysqlcommand -u$usrid --database $db < "$sqlroot/values/values_perfiles-matrices_nitruracion.mysql"
$mysqlcommand -u$usrid --database $db < "$sqlroot/values/values_pedidos.mysql"
$mysqlcommand -u$usrid --database $db < "$sqlroot/values/values_op_pintura.mysql"

