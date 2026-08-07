#!/usr/bin/env bash
set -euo pipefail

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$dir/config.sh"

$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/functions/functions_check.mysql"

# tables
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/tables/tables_usuarios-clientes.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/tables/tables_insumos.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/tables/tables_insumos_tochos.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/tables/tables_insumos_pinturas.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/tables/tables_insumos_contenedores_perfiles.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/tables/tables_perfiles-matrices.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/tables/tables_pedidos.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/tables/tables_op_extrusion.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/tables/tables_op_pintura.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/tables/tables_produccion_cortetochos.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/tables/tables_produccion_extrusion.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/tables/tables_produccion_tochos.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/tables/tables_produccion_envejecimiento.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/tables/tables_produccion_pinturas.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/tables/tables_produccion_pretratamiento.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/tables/tables_produccion_pintura.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/tables/tables_produccion_perfiles.mysql"

# values
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/values/values_usuarios-clientes.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/values/values_insumos.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/values/values_insumos_pinturas.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/values/values_insumos_contenedores_perfiles.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/values/values_perfiles-matrices.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/values/values_perfiles-matrices_nitruracion.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/values/values_pedidos.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/values/values_op_pintura.mysql"

# views
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/views/views_insumos_pinturas.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/views/views_extrusion.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/views/views_op_extrusion.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/views/views_matrices.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/views/views_pedidos.mysql"
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/views/views_produccion_plan.mysql"

# procedures
$mysqlcommand -u$usrid --database $db -vv < "$sqlroot/procedures/procedures_matrices_info.mysql"
