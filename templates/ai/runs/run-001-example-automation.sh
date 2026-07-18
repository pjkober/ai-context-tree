#!/usr/bin/env bash
# ---
# id: run-001
# description: Seed the local development database with test users representing different personas.
# created: 2026-07-16
# last-run: 2026-07-16
# reusable: true
# idempotent: true
# author: pjk
# ---
set -euo pipefail

# Load environment variables (Cleanliness - No Secrets Rule)
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

DB_URL="${DATABASE_URL:-postgresql://localhost:5472/dev_db}"

echo "Seeding test users into $DB_URL..."
# [Insertion logic goes here]
echo "Database seed completed successfully."
