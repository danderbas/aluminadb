dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
nullclean="$dir/../nullclean.sh"

"$nullclean" "$CSV_ROOT/insumos_pinturas.cargas_pinturas.csv" 

"$nullclean" "$CSV_ROOT/insumos_pinturas.colores_codigos.csv"

"$nullclean" "$CSV_ROOT/insumos_pinturas.cargas_pinturas_detalle.csv"

"$nullclean" "$CSV_ROOT/insumos_pinturas.pinturas.csv"

"$nullclean" "$CSV_ROOT/insumos_pinturas.salidas.csv"
