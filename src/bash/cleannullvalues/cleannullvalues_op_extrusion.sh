dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
nullclean="$dir/../nullclean.sh"

"$nullclean" "$CSV_ROOT/op_extrusion.generacion.csv"
"$nullclean" "$CSV_ROOT/op_extrusion.op_extrusion.csv"
"$nullclean" "$CSV_ROOT/op_extrusion.entrada.csv"
"$nullclean" "$CSV_ROOT/op_extrusion.matriz.csv"
"$nullclean" "$CSV_ROOT/op_extrusion.objetivo.csv"
"$nullclean" "$CSV_ROOT/op_extrusion.parapedido.csv"
"$nullclean" "$CSV_ROOT/op_extrusion.planeamiento.csv"

