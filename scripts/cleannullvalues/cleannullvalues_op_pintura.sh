dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
nullclean="$dir/../nullclean.sh"

"$nullclean" "$CSV_ROOT/op_pintura.generacion.csv"
"$nullclean" "$CSV_ROOT/op_pintura.op_pintura.csv"
"$nullclean" "$CSV_ROOT/op_pintura.parapedido.csv"
"$nullclean" "$CSV_ROOT/op_pintura.planeamiento.csv"
