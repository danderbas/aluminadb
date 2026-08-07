dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
nullclean="$dir/../nullclean.sh"

"$nullclean" "$CSV_ROOT/d_stock_perfiles.csv"
