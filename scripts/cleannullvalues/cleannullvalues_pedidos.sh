dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
nullclean="$dir/../nullclean.sh"

"$nullclean" "$CSV_ROOT/pedidos.generacion.csv" 
"$nullclean" "$CSV_ROOT/pedidos.pedidos.csv" 
"$nullclean" "$CSV_ROOT/pedidos.entregas.csv" 

