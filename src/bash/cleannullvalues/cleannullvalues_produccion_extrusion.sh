dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
nullclean="$dir/../nullclean.sh"

"$nullclean" "$CSV_ROOT/extrusion.extrusion.csv"

"$nullclean" "$CSV_ROOT/extrusion.matriz.csv"

"$nullclean" "$CSV_ROOT/extrusion.tochos.csv"

"$nullclean" "$CSV_ROOT/extrusion.corte.csv"

"$nullclean" "$CSV_ROOT/extrusion.produccion.csv"

"$nullclean" "$CSV_ROOT/extrusion.muestra_culote.csv"

"$nullclean" "$CSV_ROOT/extrusion.muestra_perfil.csv"

"$nullclean" "$CSV_ROOT/extrusion.stats.csv"

