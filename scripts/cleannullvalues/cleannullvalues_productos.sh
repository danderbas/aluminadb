dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
nullclean="$dir/../nullclean.sh"

"$nullclean" "$CSV_ROOT/productos.categorias_productos.csv"

"$nullclean" "$CSV_ROOT/productos.lineas_productos.csv"

"$nullclean" "$CSV_ROOT/productos.productos.csv"

"$nullclean" "$CSV_ROOT/productos.productos_perfiles.csv"

"$nullclean" "$CSV_ROOT/productos.productos_stockmin.csv"
