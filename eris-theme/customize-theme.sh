#!/bin/bash

# Eris Theme - Customization Script
# This script helps users customize the Eris theme for their Jekyll site

echo "Eris Theme Customization Script"
echo "=============================="
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
    echo "Warning: This site does not appear to be using the Eris theme."
    read -p "Continue anyway? (y/n): " continue_anyway
    if [ "$continue_anyway" != "y" ]; then
        exit 1
    fi
fi

# Main menu
while true; do
    echo
    echo "Eris Theme Customization Menu"
    echo "----------------------------"
    echo "1) Customize theme colors"
    echo "2) Customize navigation"
    echo "3) Customize social links"
    echo "4) Create custom CSS"
    echo "5) Override theme files"
    echo "6) Exit"
    echo
    read -p "Enter your choice (1-6): " menu_choice
    
    case $menu_choice in
        1)
            # Customize theme colors
            echo
            echo "Customize Theme Colors"
            echo "---------------------"
            echo "Current theme colors:"
            
            # Extract current colors from _config.yml
            primary_color=$(grep -A 2 "theme_color:" _config.yml | grep "primary:" | sed 's/.*primary: "\(.*\)".*/\1/')
            text_color=$(grep -A 2 "theme_color:" _config.yml | grep "text:" | sed 's/.*text: "\(.*\)".*/\1/')
            
            if [ -z "$primary_color" ]; then
                primary_color="#6d105a"
                echo "Primary color not found in _config.yml, using default: $primary_color"
            else
                echo "Primary color: $primary_color"
            fi
            
            if [ -z "$text_color" ]; then
                text_color="#ffffff"
                echo "Text color not found in _config.yml, using default: $text_color"
            else
                echo "Text color: $text_color"
            fi
            
            echo
            read -p "Enter new primary color (hex code, e.g., #6d105a) or press Enter to keep current: " new_primary_color
            read -p "Enter new text color (hex code, e.g., #ffffff) or press Enter to keep current: " new_text_color
            
            # Update _config.yml with new colors
            if [ -n "$new_primary_color" ] || [ -n "$new_text_color" ]; then
                # Check if theme_color section exists
                if grep -q "theme_color:" _config.yml; then
                    # Update existing colors
                    if [ -n "$new_primary_color" ]; then
                        sed -i '' "s/primary: \"$primary_color\"/primary: \"$new_primary_color\"/" _config.yml
                        echo "Primary color updated to $new_primary_color"
                    fi
                    
                    if [ -n "$new_text_color" ]; then
                        sed -i '' "s/text: \"$text_color\"/text: \"$new_text_color\"/" _config.yml
                        echo "Text color updated to $new_text_color"
                    fi
                else
                    # Add theme_color section
                    echo "" >> _config.yml
                    echo "# Theme color settings" >> _config.yml
                    echo "theme_color:" >> _config.yml
                    
                    if [ -n "$new_primary_color" ]; then
                        echo "  primary: \"$new_primary_color\"" >> _config.yml
                        echo "Primary color set to $new_primary_color"
                    else
                        echo "  primary: \"$primary_color\"" >> _config.yml
                    fi
                    
                    if [ -n "$new_text_color" ]; then
                        echo "  text: \"$new_text_color\"" >> _config.yml
                        echo "Text color set to $new_text_color"
                    else
                        echo "  text: \"$text_color\"" >> _config.yml
                    fi
                fi
                
                echo "Theme colors updated in _config.yml"
            else
                echo "No changes made to theme colors."
            fi
            ;;
        2)
            # Customize navigation
            echo
            echo "Customize Navigation"
            echo "-------------------"
            echo "Current navigation:"
            
            # Extract and display current navigation
            sed -n '/navigation:/,/^[^ ]/p' _config.yml | head -n -1
            
            echo
            echo "Would you like to:"
            echo "1) Replace the entire navigation section"
            echo "2) Keep the current navigation"
            read -p "Enter your choice (1 or 2): " nav_choice
            
            if [ "$nav_choice" == "1" ]; then
                # Create a temporary file for the new navigation
                temp_file=$(mktemp)
                
                echo "Enter your new navigation structure in YAML format."
                echo "Example:"
                echo "navigation:"
                echo "  - title: Home"
                echo "    url: /"
                echo "  - title: Blog"
                echo "    url: /blog.html"
                echo "  - title: Projects"
                echo "    url: /projects.html"
                echo "    submenu:"
                echo "      - title: Project 1"
                echo "        url: /projects/project1.html"
                echo "      - title: Project 2"
                echo "        url: /projects/project2.html"
                echo "  - title: About"
                echo "    url: /about.html"
                echo
                echo "Enter your navigation structure below (press Ctrl+D when finished):"
                cat > $temp_file
                
                # Check if navigation section exists
                if grep -q "navigation:" _config.yml; then
                    # Replace existing navigation section
                    sed -i '' '/navigation:/,/^[^ ]/d' _config.yml
                    cat $temp_file >> _config.yml
                    echo "" >> _config.yml
                else
                    # Add navigation section
                    echo "" >> _config.yml
                    cat $temp_file >> _config.yml
                    echo "" >> _config.yml
                fi
                
                rm $temp_file
                echo "Navigation updated in _config.yml"
            else
                echo "No changes made to navigation."
            fi
            ;;
        3)
            # Customize social links
            echo
            echo "Customize Social Links"
            echo "---------------------"
            echo "Current social links:"
            
            # Extract and display current social links
            sed -n '/social:/,/^[^ ]/p' _config.yml | head -n -1
            
            echo
            read -p "Enter BlueSky URL or press Enter to skip: " bluesky_url
            read -p "Enter LinkedIn URL or press Enter to skip: " linkedin_url
            read -p "Enter Instagram URL or press Enter to skip: " instagram_url
            read -p "Enter GitHub URL or press Enter to skip: " github_url
            
            # Update _config.yml with new social links
            if [ -n "$bluesky_url" ] || [ -n "$linkedin_url" ] || [ -n "$instagram_url" ] || [ -n "$github_url" ]; then
                # Check if social section exists
                if grep -q "social:" _config.yml; then
                    # Replace existing social section
                    sed -i '' '/social:/,/^[^ ]/d' _config.yml
                else
                    # Add a blank line before adding social section
                    echo "" >> _config.yml
                fi
                
                # Add new social section
                echo "# Social media links" >> _config.yml
                echo "social:" >> _config.yml
                
                if [ -n "$bluesky_url" ]; then
                    echo "  bluesky: \"$bluesky_url\"" >> _config.yml
                fi
                
                if [ -n "$linkedin_url" ]; then
                    echo "  linkedin: \"$linkedin_url\"" >> _config.yml
                fi
                
                if [ -n "$instagram_url" ]; then
                    echo "  instagram: \"$instagram_url\"" >> _config.yml
                fi
                
                if [ -n "$github_url" ]; then
                    echo "  github: \"$github_url\"" >> _config.yml
                fi
                
                echo "" >> _config.yml
                echo "Social links updated in _config.yml"
            else
                echo "No changes made to social links."
            fi
            ;;
        4)
            # Create custom CSS
            echo
            echo "Create Custom CSS"
            echo "----------------"
            
            # Check if assets/css directory exists
            if [ ! -d "assets/css" ]; then
                mkdir -p assets/css
                echo "Created assets/css directory."
            fi
            
            # Check if main.scss exists
            if [ -f "assets/css/main.scss" ]; then
                echo "assets/css/main.scss already exists."
                read -p "Would you like to overwrite it? (y/n): " overwrite_css
                if [ "$overwrite_css" != "y" ]; then
                    echo "No changes made to CSS."
                    continue
                fi
            fi
            
            # Create main.scss
            cat > assets/css/main.scss << EOL
---
---

// Import variables and set theme colors from config
\$primary-color: {{ site.theme_color.primary | default: "#6d105a" }};
\$text-color: {{ site.theme_color.text | default: "#ffffff" }};

// Import Eris theme
@import "eris";

// Add your custom styles below this line
// Example:
// .custom-component {
//   background-color: rgba(\$primary-color, 0.2);
//   border: 1px solid \$primary-color;
//   padding: 20px;
//   margin: 20px 0;
//   border-radius: 5px;
// }
EOL
            
            echo "Created assets/css/main.scss with template for custom styles."
            echo "You can now edit this file to add your custom CSS."
            ;;
        5)
            # Override theme files
            echo
            echo "Override Theme Files"
            echo "-------------------"
            echo "Which theme files would you like to override?"
            echo "1) Layout files (_layouts)"
            echo "2) Include files (_includes)"
            echo "3) Sass files (_sass)"
            echo "4) Return to main menu"
            read -p "Enter your choice (1-4): " override_choice
            
            case $override_choice in
                1)
                    # Override layout files
                    echo
                    echo "Override Layout Files"
                    echo "--------------------"
                    
                    # Check if _layouts directory exists
                    if [ ! -d "_layouts" ]; then
                        mkdir -p _layouts
                        echo "Created _layouts directory."
                    fi
                    
                    echo "Available layout files to override:"
                    echo "1) default.html (main layout)"
                    echo "2) post.html (blog post layout)"
                    echo "3) Both files"
                    echo "4) Cancel"
                    read -p "Enter your choice (1-4): " layout_choice
                    
                    case $layout_choice in
                        1)
                            # Copy default.html from theme
                            cp -v /Users/kali/eris-theme/eris-theme/_layouts/default.html _layouts/
                            echo "Copied default.html to _layouts/. You can now edit this file to customize it."
                            ;;
                        2)
                            # Copy post.html from theme
                            cp -v /Users/kali/eris-theme/eris-theme/_layouts/post.html _layouts/
                            echo "Copied post.html to _layouts/. You can now edit this file to customize it."
                            ;;
                        3)
                            # Copy both layout files
                            cp -v /Users/kali/eris-theme/eris-theme/_layouts/*.html _layouts/
                            echo "Copied all layout files to _layouts/. You can now edit these files to customize them."
                            ;;
                        4)
                            echo "No layout files copied."
                            ;;
                        *)
                            echo "Invalid choice. No layout files copied."
                            ;;
                    esac
                    ;;
                2)
                    # Override include files
                    echo
                    echo "Override Include Files"
                    echo "---------------------"
                    
                    # Check if _includes directory exists
                    if [ ! -d "_includes" ]; then
                        mkdir -p _includes
                        echo "Created _includes directory."
                    fi
                    
                    echo "Available include files to override:"
                    echo "1) header.html (site header)"
                    echo "2) footer.html (site footer)"
                    echo "3) Both files"
                    echo "4) Cancel"
                    read -p "Enter your choice (1-4): " include_choice
                    
                    case $include_choice in
                        1)
                            # Copy header.html from theme
                            cp -v /Users/kali/eris-theme/eris-theme/_includes/header.html _includes/
                            echo "Copied header.html to _includes/. You can now edit this file to customize it."
                            ;;
                        2)
                            # Copy footer.html from theme
                            cp -v /Users/kali/eris-theme/eris-theme/_includes/footer.html _includes/
                            echo "Copied footer.html to _includes/. You can now edit this file to customize it."
                            ;;
                        3)
                            # Copy both include files
                            cp -v /Users/kali/eris-theme/eris-theme/_includes/*.html _includes/
                            echo "Copied all include files to _includes/. You can now edit these files to customize them."
                            ;;
                        4)
                            echo "No include files copied."
                            ;;
                        *)
                            echo "Invalid choice. No include files copied."
                            ;;
                    esac
                    ;;
                3)
                    # Override sass files
                    echo
                    echo "Override Sass Files"
                    echo "------------------"
                    
                    # Check if _sass directory exists
                    if [ ! -d "_sass" ]; then
                        mkdir -p _sass
                        echo "Created _sass directory."
                    fi
                    
                    echo "Available sass files to override:"
                    echo "1) _variables.scss (theme variables)"
                    echo "2) _base.scss (base styles)"
                    echo "3) _layout.scss (layout styles)"
                    echo "4) _components.scss (component styles)"
                    echo "5) _responsive.scss (responsive styles)"
                    echo "6) eris.scss (main sass file)"
                    echo "7) All files"
                    echo "8) Cancel"
                    read -p "Enter your choice (1-8): " sass_choice
                    
                    case $sass_choice in
                        1)
                            # Copy _variables.scss from theme
                            cp -v /Users/kali/eris-theme/eris-theme/_sass/_variables.scss _sass/
                            echo "Copied _variables.scss to _sass/. You can now edit this file to customize it."
                            ;;
                        2)
                            # Copy _base.scss from theme
                            cp -v /Users/kali/eris-theme/eris-theme/_sass/_base.scss _sass/
                            echo "Copied _base.scss to _sass/. You can now edit this file to customize it."
                            ;;
                        3)
                            # Copy _layout.scss from theme
                            cp -v /Users/kali/eris-theme/eris-theme/_sass/_layout.scss _sass/
                            echo "Copied _layout.scss to _sass/. You can now edit this file to customize it."
                            ;;
                        4)
                            # Copy _components.scss from theme
                            cp -v /Users/kali/eris-theme/eris-theme/_sass/_components.scss _sass/
                            echo "Copied _components.scss to _sass/. You can now edit this file to customize it."
                            ;;
                        5)
                            # Copy _responsive.scss from theme
                            cp -v /Users/kali/eris-theme/eris-theme/_sass/_responsive.scss _sass/
                            echo "Copied _responsive.scss to _sass/. You can now edit this file to customize it."
                            ;;
                        6)
                            # Copy eris.scss from theme
                            cp -v /Users/kali/eris-theme/eris-theme/_sass/eris.scss _sass/
                            echo "Copied eris.scss to _sass/. You can now edit this file to customize it."
                            ;;
                        7)
                            # Copy all sass files
                            cp -v /Users/kali/eris-theme/eris-theme/_sass/*.scss _sass/
                            echo "Copied all sass files to _sass/. You can now edit these files to customize them."
                            ;;
                        8)
                            echo "No sass files copied."
                            ;;
                        *)
                            echo "Invalid choice. No sass files copied."
                            ;;
                    esac
                    ;;
                4)
                    echo "Returning to main menu."
                    ;;
                *)
                    echo "Invalid choice. Returning to main menu."
                    ;;
            esac
            ;;
        6)
            # Exit
            echo "Exiting customization script."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a number between 1 and 6."
            ;;
    esac
done
