#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# build.sh — build the "upload-only" frontend locally
# -----------------------------------------------------------------------------

echo "Installing dependencies…"
yarn install --frozen-lockfile

echo "Type-checking with tsc…"
yarn tsc --noemit

echo "Linting with ESLint…"
npx eslint --ext .js,.jsx,.ts,.tsx src

echo "Building production bundle…"
yarn build

echo "Build complete. Output lives in upload-only/dist (or wherever your build outputs to)."
