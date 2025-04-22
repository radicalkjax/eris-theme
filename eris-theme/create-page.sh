#!/bin/bash

# Eris Theme - Create Page Script
# This script helps users create a new page for their Jekyll site

echo "Eris Theme - Create Page"
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

# Get page details
echo
echo "Enter the details for your new page:"
read -p "Title: " page_title
read -p "URL (e.g., about.html, projects/project3.html): " page_url

# Check if URL is provided
if [ -z "$page_url" ]; then
    echo "Error: URL is required."
    exit 1
fi

# Create directory if needed
page_dir=$(dirname "$page_url")
if [ "$page_dir" != "." ] && [ ! -d "$page_dir" ]; then
    mkdir -p "$page_dir"
    echo "Created directory: $page_dir"
fi

# Check if file already exists
if [ -f "$page_url" ]; then
    echo "Error: A page with this URL already exists."
    echo "Please choose a different URL or edit the existing page."
    exit 1
fi

# Create page file
cat > "$page_url" << EOL
---
layout: default
title: "${page_title}"
---

<div class="post-card">
  <h1 class="post-title">${page_title}</h1>
  <div class="post-content">
    <p>Write your page content here. This is an HTML file, so you can use HTML tags to format your content.</p>
    
    <h2>Section Heading</h2>
    <p>Regular paragraph text.</p>
    
    <h3>Subsection Heading</h3>
    <p>More content...</p>
    
    <p><strong>Bold text</strong> and <em>italic text</em>.</p>
    
    <blockquote>
      <p>This is a blockquote.</p>
    </blockquote>
    
    <pre><code>
// This is a code block
function helloWorld() {
  console.log("Hello, world!");
}
    </code></pre>
    
    <div class="mermaid">
      graph TD
        A[Start] --> B[Process]
        B --> C[End]
    </div>
    
    <ul>
      <li>Unordered list item 1</li>
      <li>Unordered list item 2</li>
      <li>Unordered list item 3</li>
    </ul>
    
    <ol>
      <li>Ordered list item 1</li>
      <li>Ordered list item 2</li>
      <li>Ordered list item 3</li>
    </ol>
    
    <p><a href="https://example.com">Link text</a></p>
    
    <p><img src="https://example.com/image.jpg" alt="Image alt text"></p>
  </div>
</div>
EOL

echo
echo "Page created successfully!"
echo "File: $page_url"
echo
echo "To preview your site with the new page, run:"
echo "bundle exec jekyll serve"
echo
echo "Would you like to open the page in your default editor?"
read -p "Enter 'y' to open, any other key to exit: " open_editor

if [ "$open_editor" == "y" ]; then
    if [ -n "$EDITOR" ]; then
        $EDITOR "$page_url"
    elif command -v code &> /dev/null; then
        code "$page_url"
    elif command -v nano &> /dev/null; then
        nano "$page_url"
    elif command -v vim &> /dev/null; then
        vim "$page_url"
    else
        echo "No editor found. Please open the file manually."
    fi
fi

# Ask if the user wants to add the page to navigation
echo
echo "Would you like to add this page to the navigation menu in _config.yml?"
read -p "Enter 'y' to add, any other key to skip: " add_to_nav

if [ "$add_to_nav" == "y" ]; then
    # Check if navigation section exists
    if grep -q "navigation:" _config.yml; then
        echo
        echo "Current navigation:"
        sed -n '/navigation:/,/^[^ ]/p' _config.yml | head -n -1
        
        echo
        echo "Where would you like to add the new page?"
        echo "1) As a top-level menu item"
        echo "2) As a submenu item under an existing menu item"
        read -p "Enter your choice (1 or 2): " nav_choice
        
        if [ "$nav_choice" == "1" ]; then
            # Add as top-level menu item
            page_path="/$page_url"
            sed -i '' "/navigation:/,/^[^ ]/ s/^[^ ]/  - title: \"$page_title\"\n    url: \"$page_path\"\n&/" _config.yml
            echo "Added \"$page_title\" to navigation menu."
        elif [ "$nav_choice" == "2" ]; then
            # Add as submenu item
            echo
            echo "Under which menu item would you like to add this page?"
            
            # Extract and display top-level menu items
            menu_items=$(sed -n '/navigation:/,/^[^ ]/ s/.*title: "\([^"]*\)".*/\1/p' _config.yml)
            menu_count=0
            
            echo "$menu_items" | while read -r item; do
                menu_count=$((menu_count + 1))
                echo "$menu_count) $item"
            done
            
            read -p "Enter the number of the parent menu item: " parent_choice
            
            # Get the parent menu item
            parent_item=$(echo "$menu_items" | sed -n "${parent_choice}p")
            
            if [ -n "$parent_item" ]; then
                # Check if the parent already has a submenu
                if grep -q "title: \"$parent_item\"" _config.yml && grep -q "submenu:" _config.yml; then
                    # Add to existing submenu
                    page_path="/$page_url"
                    sed -i '' "/title: \"$parent_item\"/,/^[^ ]/ s/^[^ ]/      - title: \"$page_title\"\n        url: \"$page_path\"\n&/" _config.yml
                else
                    # Create new submenu
                    page_path="/$page_url"
                    sed -i '' "/title: \"$parent_item\"/,/^[^ ]/ s/^[^ ]/    submenu:\n      - title: \"$page_title\"\n        url: \"$page_path\"\n&/" _config.yml
                fi
                
                echo "Added \"$page_title\" as a submenu item under \"$parent_item\"."
            else
                echo "Invalid parent menu item. Navigation not updated."
            fi
        else
            echo "Invalid choice. Navigation not updated."
        fi
    else
        # Create new navigation section
        echo
        echo "No navigation section found in _config.yml."
        echo "Would you like to create a new navigation section with this page?"
        read -p "Enter 'y' to create, any other key to skip: " create_nav
        
        if [ "$create_nav" == "y" ]; then
            # Create new navigation section
            page_path="/$page_url"
            cat >> _config.yml << EOL

# Navigation
navigation:
  - title: "Home"
    url: "/"
  - title: "${page_title}"
    url: "${page_path}"
EOL
            echo "Created new navigation section with \"$page_title\"."
        else
            echo "Navigation not updated."
        fi
    fi
fi

echo "Done!"
