#!/usr/bin/env bash
set -euo pipefail

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$dir/install/install_config.sh"

loaddir="$sqlroot/load"
cleandir="$dir/cleannullvalues"

load() {
	local cleanscript=$1
	local loadfile=$2
	bash "$cleandir/$cleanscript"
	sed "s#@@CSVFOLDER@@#$CSV_ROOT#g" "$loaddir/$loadfile" | $mysqlcommand -u$usrid --database $db -vv
}

load cleannullvalues_usuarios-clientes.sh loadvalues_usuarios-clientes.mysql

load cleannullvalues_insumos_tochos.sh loadvalues_insumos_tochos.mysql
load cleannullvalues_insumos_pinturas.sh loadvalues_insumos_pinturas.mysql

load cleannullvalues_perfiles-matrices.sh loadvalues_perfiles-matrices.mysql

load cleannullvalues_pedidos.sh loadvalues_pedidos.mysql

load cleannullvalues_op_extrusion.sh loadvalues_op_extrusion.mysql
load cleannullvalues_op_pintura.sh loadvalues_op_pintura.mysql

load cleannullvalues_produccion_cortetochos.sh loadvalues_produccion_cortetochos.mysql

load cleannullvalues_produccion_extrusion.sh loadvalues_produccion_extrusion.mysql

load cleannullvalues_produccion_envejecimiento.sh loadvalues_produccion_envejecimiento.mysql

load cleannullvalues_productos.sh loadvalues_productos.mysql
