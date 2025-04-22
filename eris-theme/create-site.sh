#!/bin/bash

# Eris Theme - Create New Site Script
# This script creates a new Jekyll site with the Eris theme

echo "Create New Jekyll Site with Eris Theme"
echo "====================================="
echo

# Check if Jekyll is installed
if ! command -v jekyll &> /dev/null; then
    echo "Jekyll is not installed. Please install Jekyll first:"
    echo "gem install jekyll bundler"
    exit 1
fi

# Ask for site name
read -p "Enter your site name (e.g., my-blog): " site_name

# Check if directory already exists
if [ -d "$site_name" ]; then
    echo "Error: Directory '$site_name' already exists."
    exit 1
fi

# Create a new Jekyll site
echo "Creating new Jekyll site..."
jekyll new "$site_name"
cd "$site_name"

# Add Eris theme to Gemfile
echo "Adding Eris theme to Gemfile..."
if grep -q "gem \"minima\"" Gemfile; then
    sed -i '' 's/gem "minima".*/gem "eris-theme", path: "..\/eris-theme"/' Gemfile
else
    echo 'gem "eris-theme", path: "../eris-theme"' >> Gemfile
fi

# Update _config.yml
echo "Updating _config.yml..."
if grep -q "theme: minima" _config.yml; then
    sed -i '' 's/theme: minima/theme: eris-theme/' _config.yml
else
    echo 'theme: eris-theme' >> _config.yml
fi

# Add navigation to _config.yml
echo "Adding navigation to _config.yml..."
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

# Create necessary directories
echo "Creating necessary directories..."
mkdir -p projects

# Copy sample pages
echo "Copying sample pages..."
cp -r ../eris-theme/projects/* projects/
cp ../eris-theme/blog.html .
cp ../eris-theme/about.html .
cp ../eris-theme/contact.html .
cp ../eris-theme/projects.html .

# Install dependencies
echo "Installing dependencies..."
bundle install

echo "Setup complete! Your new Jekyll site with Eris theme is ready."
echo "To start the development server, run:"
echo "cd $site_name && bundle exec jekyll serve"
