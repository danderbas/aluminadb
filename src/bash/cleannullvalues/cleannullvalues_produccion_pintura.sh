dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
nullclean="$dir/../nullclean.sh"

"$nullclean" "$CSV_ROOT/pintura.csv"
