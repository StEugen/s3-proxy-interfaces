#!/bin/bash
set -e

export MINIO_ROOT_USER=minioadmin
export MINIO_ROOT_PASSWORD=minioadmin

minio server /data --address ":4569" &
MINIO_PID=$!

until curl -s http://127.0.0.1:4569/minio/health/ready; do
	echo "Waiting for MinIO..."
	sleep 1
done

mc alias set local http://127.0.0.1:4569 "$MINIO_ROOT_USER" "$MINIO_ROOT_PASSWORD"

mc mb local/frontend || true
mc cp --recursive /app/build/* local/frontend

kill $MINIO_PID
wait $MINIO_PID 2>/dev/null || true

exec minio server /data --address ":4569"
