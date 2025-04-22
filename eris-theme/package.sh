#!/bin/bash

# Eris Theme Packaging Script
# This script packages the Eris theme as a Ruby gem

echo "Packaging Eris theme as a Ruby gem..."

# Navigate to the theme directory
cd "$(dirname "$0")"

# Build the gem
gem build eris-theme.gemspec

# Check if the build was successful
if [ $? -eq 0 ]; then
    echo "Gem built successfully!"
    echo "To install the gem locally, run:"
    echo "gem install eris-theme-*.gem"
    echo ""
    echo "To publish the gem to RubyGems, run:"
    echo "gem push eris-theme-*.gem"
else
    echo "Error building gem. Please check the error messages above."
fi
