#!/bin/bash
set -e

s3rver --port 4569 --address 127.0.0.1 --directory /tmp &
S3_PID=$!

sleep 2

aws --endpoint-url http://localhost:4569 s3 mb s3://frontend
aws --endpoint-url http://localhost:4569 s3 sync /app/build s3://frontend

kill $S3_PID
wait $S3_PID 2>/dev/null || true

exec s3rver --port 4569 --address 0.0.0.0 --directory /tmp
