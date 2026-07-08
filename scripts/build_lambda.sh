#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="$ROOT_DIR/build/app"

rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

pip install -r "$ROOT_DIR/app/requirements.txt" -t "$BUILD_DIR" --quiet
cp -r "$ROOT_DIR/app" "$BUILD_DIR/app"
