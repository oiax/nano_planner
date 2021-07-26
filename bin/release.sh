#!/bin/bash
set -eu

export MIX_ENV=prod
mix deps.get --only :prod
mix deps.compile
(cd assets && npm run deploy)
mix phx.digest
mix release
