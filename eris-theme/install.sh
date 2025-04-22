#!/bin/bash

# Eris Theme Installation Script
# This script helps users install the Eris theme in their Jekyll site

echo "Eris Theme Installation Script"
echo "============================="
echo

# Check if Jekyll is installed
if ! command -v jekyll &> /dev/null; then
    echo "Jekyll is not installed. Please install Jekyll first:"
    echo "gem install jekyll bundler"
    exit 1
fi

# Ask if this is a new or existing site
echo "Is this a new Jekyll site or an existing one?"
echo "1) New site (create a new Jekyll site with Eris theme)"
echo "2) Existing site (add Eris theme to an existing Jekyll site)"
read -p "Enter your choice (1 or 2): " site_choice

if [ "$site_choice" == "1" ]; then
    # New site
    read -p "Enter your site name (e.g., my-blog): " site_name
    
    # Create a new Jekyll site
    jekyll new "$site_name"
    cd "$site_name"
    
    # Add Eris theme to Gemfile
    if grep -q "gem \"minima\"" Gemfile; then
        sed -i '' 's/gem "minima".*/gem "eris-theme"/' Gemfile
    else
        echo 'gem "eris-theme"' >> Gemfile
    fi
    
    # Update _config.yml
    if grep -q "theme: minima" _config.yml; then
        sed -i '' 's/theme: minima/theme: eris-theme/' _config.yml
    else
        echo 'theme: eris-theme' >> _config.yml
    fi
    
    # Add navigation to _config.yml
    cat >> _config.yml << EOL

# Navigation
navigation:
  - title: Blog
    url: /blog.html
  - title: Projects
    url: /projects.html
    submenu:
      - title: Project 1
        url: /projects/project1.html
      - title: Project 2
        url: /projects/project2.html
  - title: About
    url: /about.html
  - title: Contact
    url: /contact.html

# Theme color settings
theme_color:
  primary: "#6d105a"
  text: "#ffffff"

# Social media links
social:
  bluesky: https://bsky.app/profile/yourusername
  linkedin: https://www.linkedin.com/in/yourusername
  instagram: https://www.instagram.com/yourusername
  github: https://github.com/yourusername
EOL
    
    # Install dependencies
    bundle install
    
    echo "Setup complete! Your new Jekyll site with Eris theme is ready."
    echo "To start the development server, run:"
    echo "cd $site_name && bundle exec jekyll serve"
    
else
    # Existing site
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
    
    # Add Eris theme to Gemfile
    if grep -q "gem \"eris-theme\"" Gemfile; then
        echo "Eris theme is already in your Gemfile."
    else
        echo 'gem "eris-theme"' >> Gemfile
    fi
    
    # Update _config.yml
    if grep -q "theme: eris-theme" _config.yml; then
        echo "Eris theme is already set in your _config.yml."
    else
        # Check if another theme is set
        if grep -q "theme:" _config.yml; then
            read -p "Another theme is already set in your _config.yml. Replace it with Eris? (y/n): " replace_theme
            if [ "$replace_theme" == "y" ]; then
                sed -i '' 's/theme:.*/theme: eris-theme/' _config.yml
            fi
        else
            echo 'theme: eris-theme' >> _config.yml
        fi
    fi
    
    # Ask if they want to add sample navigation
    read -p "Would you like to add sample navigation to your _config.yml? (y/n): " add_nav
    if [ "$add_nav" == "y" ]; then
        cat >> _config.yml << EOL

# Navigation
navigation:
  - title: Blog
    url: /blog.html
  - title: Projects
    url: /projects.html
    submenu:
      - title: Project 1
        url: /projects/project1.html
      - title: Project 2
        url: /projects/project2.html
  - title: About
    url: /about.html
  - title: Contact
    url: /contact.html

# Theme color settings
theme_color:
  primary: "#6d105a"
  text: "#ffffff"

# Social media links
social:
  bluesky: https://bsky.app/profile/yourusername
  linkedin: https://www.linkedin.com/in/yourusername
  instagram: https://www.instagram.com/yourusername
  github: https://github.com/yourusername
EOL
    fi
    
    # Install dependencies
    bundle install
    
    echo "Setup complete! Your existing Jekyll site now uses the Eris theme."
    echo "To start the development server, run:"
    echo "cd $site_path && bundle exec jekyll serve"
fi
