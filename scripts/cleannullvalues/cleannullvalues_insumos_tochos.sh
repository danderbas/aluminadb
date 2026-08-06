dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
nullclean="$dir/../nullclean.sh"

"$nullclean" "$CSV_ROOT/insumos_tocho0.cargas_aluminio.csv" 

"$nullclean" "$CSV_ROOT/insumos_tocho0.cargas_aluminio_packinglist.csv"

"$nullclean" "$CSV_ROOT/insumos_tocho0.tocho0.csv"
