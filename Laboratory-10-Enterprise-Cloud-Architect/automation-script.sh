#!/usr/bin/env bash
# CloudNova operations: database backup with retention.
set -Eeuo pipefail
umask 077

PROJECT_DIR="/opt/cloudnova"
BACKUP_DIR="${PROJECT_DIR}/backups"
RETENTION_DAYS=7
TIMESTAMP="$(date +'%Y%m%d_%H%M%S')"
LOG_FILE="/var/log/cloudnova-backup.log"

mkdir -p "$BACKUP_DIR"
cd "$PROJECT_DIR"

{
  echo "[$(date --iso-8601=seconds)] Starting MariaDB backup"
  if ! docker compose ps --status running --services | grep -qx 'db'; then
    echo "ERROR: db service is not running"
    exit 1
  fi

  OUT="${BACKUP_DIR}/mariadb_${TIMESTAMP}.sql.gz"
  docker compose exec -T db sh -c \
    'exec mariadb-dump --single-transaction -u"$MARIADB_USER" -p"$MARIADB_PASSWORD" "$MARIADB_DATABASE"' \
    | gzip > "$OUT"

  test -s "$OUT"
  gzip -t "$OUT"
  find "$BACKUP_DIR" -type f -name 'mariadb_*.sql.gz' -mtime +"$RETENTION_DAYS" -delete
  echo "Backup successful: $OUT"
  echo "[$(date --iso-8601=seconds)] Backup finished"
} >> "$LOG_FILE" 2>&1
