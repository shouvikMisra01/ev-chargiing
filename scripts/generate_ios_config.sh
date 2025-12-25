#!/bin/bash

# Generate iOS Config.swift from .env
# This script is called during iOS build

set -e

# Load .env file
if [ -f "../../.env" ]; then
    export $(cat ../../.env | grep -v '^#' | xargs)
elif [ -f ".env" ]; then
    export $(cat .env | grep -v '^#' | xargs)
else
    echo "Warning: .env file not found"
    GOOGLE_MAPS_API_KEY="YOUR_GOOGLE_MAPS_API_KEY_HERE"
fi

# Generate Config.swift
cat > ios/Runner/Config.swift << EOF
// Auto-generated from .env - DO NOT EDIT MANUALLY
// Run: ./scripts/generate_config.sh to regenerate

import Foundation

struct AppConfig {
    static let googleMapsApiKey = "${GOOGLE_MAPS_API_KEY}"
}
EOF

echo "Generated ios/Runner/Config.swift"
