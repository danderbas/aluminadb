REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

set -a
source "$REPO_ROOT/.env"
set +a

hostname="${MYSQL_HOST:-127.0.0.1}"
usrid="$MYSQL_USER"
db="$MYSQL_DATABASE"
mysqlcommand="mysql -h$hostname -P${MYSQL_PORT:-3306} -p$MYSQL_PASSWORD --local-infile=1 --show-warnings"

sqlroot="$REPO_ROOT/src/mysql"

# CSV_ROOT from .env may be given relative to the repo root; resolve it to an
# absolute path since LOAD DATA LOCAL INFILE resolves relative paths against
# the mysql client's CWD, not the repo root.
case "$CSV_ROOT" in
	/*) ;;
	*) CSV_ROOT="$REPO_ROOT/${CSV_ROOT#./}" ;;
esac
