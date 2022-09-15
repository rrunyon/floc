#!/usr/bin/env bash
# exit on error
set -o errexit

# Initial setup
mix deps.get --only prod
MIX_ENV=prod mix compile

# Compile assets
MIX_ENV=prod mix assets.deploy

# DB migrations
MIX_ENV=prod mix ecto.create
MIX_ENV=prod mix ecto.migrate

# Build the release and overwrite the existing release directory
MIX_ENV=prod mix release --overwrite
