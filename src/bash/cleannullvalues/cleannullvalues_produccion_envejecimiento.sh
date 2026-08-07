dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
nullclean="$dir/../nullclean.sh"

"$nullclean" "$CSV_ROOT/envejecimiento.envejecimiento.csv"

"$nullclean" "$CSV_ROOT/envejecimiento.canastos.csv"

"$nullclean" "$CSV_ROOT/envejecimiento.contenido.csv"

