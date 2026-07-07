#!/usr/bin/env bash
set -euo pipefail

# Run NNN: run-001-seed-test-users
# Purpose: Seed the local development database with test users representing different personas.
# Triggered by: AI agent or developer before running integration tests.
# ------------------------------------------------------------------------------------------

# Load environment variables (Zasada czystości - No Secrets Rule)
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

DB_URL="${DATABASE_URL:-postgresql://localhost:5472/dev_db}"

echo "Seeding test users into $DB_URL..."
# [Insertion logic goes here]
echo "Database seed completed successfully."
