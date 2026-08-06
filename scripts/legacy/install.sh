#!/usr/bin/env bash
set -euo pipefail

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$dir/install_config.sh"
source "$dir/install_functions.sh"
source "$dir/install_tables.sh"
source "$dir/install_values.sh"
source "$dir/install_procedures.sh"
