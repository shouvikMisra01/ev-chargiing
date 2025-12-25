#!/bin/bash

# Script to generate config files from .env
# This ensures .env is the single source of truth

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Generating config files from .env...${NC}"

# Check if .env exists
if [ ! -f ".env" ]; then
    echo -e "${YELLOW}Warning: .env file not found!${NC}"
    echo "Copying .env.example to .env..."
    cp .env.example .env
    echo -e "${YELLOW}Please edit .env and add your API keys, then run this script again.${NC}"
    exit 1
fi

# Load .env file
export $(cat .env | grep -v '^#' | xargs)

# Generate lib/core/config/api_keys.dart
echo -e "${GREEN}Generating lib/core/config/api_keys.dart...${NC}"
mkdir -p lib/core/config
cat > lib/core/config/api_keys.dart << EOF
// API Keys Configuration
// This file is AUTO-GENERATED from .env - DO NOT EDIT MANUALLY
// Run: ./scripts/generate_config.sh to regenerate

class ApiKeys {
  /// Google Maps API Key
  /// Used for: Maps on Android, iOS, and Web
  static const String googleMapsApiKey = '${GOOGLE_MAPS_API_KEY}';

  // Add other API keys here as needed
}
EOF

# Generate ios/Runner/Config.swift for iOS
echo -e "${GREEN}Generating ios/Runner/Config.swift...${NC}"
mkdir -p ios/Runner
cat > ios/Runner/Config.swift << EOF
// Auto-generated from .env - DO NOT EDIT MANUALLY
// Run: ./scripts/generate_config.sh to regenerate

import Foundation

struct AppConfig {
    static let googleMapsApiKey = "${GOOGLE_MAPS_API_KEY}"
}
EOF

echo -e "${GREEN}✅ Config files generated successfully!${NC}"
echo ""
echo "Generated files:"
echo "  - lib/core/config/api_keys.dart (Flutter/Dart)"
echo "  - ios/Runner/Config.swift (iOS)"
echo ""
echo "Platform-specific:"
echo "  - Android: Reads .env directly via build.gradle"
echo "  - Web: Uses lib/core/config/api_keys.dart (via Flutter)"
echo ""
echo -e "${YELLOW}Note: All generated files are gitignored and safe for your API keys.${NC}"
