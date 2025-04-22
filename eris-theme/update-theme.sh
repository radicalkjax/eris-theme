#!/bin/bash

# Eris Theme - Update Script
# This script helps users update the Eris theme in their Jekyll site

echo "Eris Theme Update Script"
echo "======================="
echo

# Check if Jekyll is installed
if ! command -v jekyll &> /dev/null; then
    echo "Jekyll is not installed. Please install Jekyll first:"
    echo "gem install jekyll bundler"
    exit 1
fi

# Ask for the path to the Jekyll site
read -p "Enter the path to your Jekyll site: " site_path

# Check if the path exists
if [ ! -d "$site_path" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

cd "$site_path"

# Check if it's a Jekyll site
if [ ! -f "_config.yml" ]; then
    echo "Error: This does not appear to be a Jekyll site (_config.yml not found)."
    exit 1
fi

# Check if the site is using Eris theme
if ! grep -q "theme: eris-theme" _config.yml && ! grep -q "remote_theme: radicalkjax/eris-theme" _config.yml; then
    echo "Error: This site does not appear to be using the Eris theme."
    echo "Please check your _config.yml file."
    exit 1
fi

# Ask how the theme is installed
echo "How is the Eris theme installed in your site?"
echo "1) As a Ruby gem"
echo "2) As a remote theme (GitHub Pages)"
echo "3) As a local theme (copied files)"
read -p "Enter your choice (1, 2, or 3): " install_type

case $install_type in
    1)
        # Ruby gem
        echo "Updating Eris theme gem..."
        if grep -q "gem \"eris-theme\"" Gemfile; then
            # Update dependencies
            bundle update eris-theme
            echo "Eris theme gem updated successfully."
        else
            echo "Error: Eris theme gem not found in Gemfile."
            exit 1
        fi
        ;;
    2)
        # Remote theme
        echo "Updating remote theme reference..."
        if grep -q "remote_theme: radicalkjax/eris-theme" _config.yml; then
            echo "Remote theme reference is already up to date."
            echo "The latest version will be used automatically when you build your site."
        else
            echo "Error: Remote theme reference not found in _config.yml."
            exit 1
        fi
        ;;
    3)
        # Local theme (copied files)
        echo "Updating local theme files..."
        read -p "Enter the path to the Eris theme directory: " theme_path
        
        if [ ! -d "$theme_path" ]; then
            echo "Error: Eris theme directory not found."
            exit 1
        fi
        
        # Update theme files
        echo "Copying theme files..."
        
        # Update layouts
        if [ -d "_layouts" ]; then
            read -p "Update layouts? (y/n): " update_layouts
            if [ "$update_layouts" == "y" ]; then
                cp -r "$theme_path/_layouts/"* "_layouts/"
                echo "Layouts updated."
            fi
        fi
        
        # Update includes
        if [ -d "_includes" ]; then
            read -p "Update includes? (y/n): " update_includes
            if [ "$update_includes" == "y" ]; then
                cp -r "$theme_path/_includes/"* "_includes/"
                echo "Includes updated."
            fi
        fi
        
        # Update sass
        if [ -d "_sass" ]; then
            read -p "Update sass files? (y/n): " update_sass
            if [ "$update_sass" == "y" ]; then
                cp -r "$theme_path/_sass/"* "_sass/"
                echo "Sass files updated."
            fi
        fi
        
        # Update assets
        if [ -d "assets" ]; then
            read -p "Update assets (CSS, JS, fonts)? (y/n): " update_assets
            if [ "$update_assets" == "y" ]; then
                # Update CSS
                if [ -d "assets/css" ] && [ -d "$theme_path/assets/css" ]; then
                    cp -r "$theme_path/assets/css/"* "assets/css/"
                fi
                
                # Update JS
                if [ -d "assets/js" ] && [ -d "$theme_path/assets/js" ]; then
                    cp -r "$theme_path/assets/js/"* "assets/js/"
                fi
                
                # Update fonts
                if [ -d "assets/fonts" ] && [ -d "$theme_path/assets/fonts" ]; then
                    cp -r "$theme_path/assets/fonts/"* "assets/fonts/"
                fi
                
                echo "Assets updated."
            fi
        fi
        
        echo "Local theme files updated successfully."
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Theme update complete."
echo "To see the changes, run: bundle exec jekyll serve"
