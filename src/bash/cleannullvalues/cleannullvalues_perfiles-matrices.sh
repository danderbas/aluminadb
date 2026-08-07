dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
nullclean="$dir/../nullclean.sh"

"$nullclean" "$CSV_ROOT/perfiles.csv" 

"$nullclean" "$CSV_ROOT/matrices.matrices.csv"
"$nullclean" "$CSV_ROOT/matrices.mediciondureza.csv"
"$nullclean" "$CSV_ROOT/matrices.correcciones.csv"
"$nullclean" "$CSV_ROOT/matrices.stock_matrices.csv"
"$nullclean" "$CSV_ROOT/matrices.nitruracion.csv"

