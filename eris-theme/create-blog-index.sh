#!/bin/bash

# Eris Theme - Create Blog Index Script
# This script helps users create a blog index page for their Jekyll site

echo "Eris Theme - Create Blog Index"
echo "============================"
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

# Check if blog.html already exists
if [ -f "blog.html" ]; then
    echo "blog.html already exists."
    read -p "Would you like to overwrite it? (y/n): " overwrite_blog
    if [ "$overwrite_blog" != "y" ]; then
        echo "No changes made to blog.html."
        exit 0
    fi
fi

# Get blog details
echo
echo "Enter the details for your blog index page:"
read -p "Blog Title (default: Blog): " blog_title
read -p "Posts per page (default: 10): " posts_per_page
read -p "Show post excerpts? (y/n, default: y): " show_excerpts
read -p "Show post dates? (y/n, default: y): " show_dates
read -p "Show post tags? (y/n, default: y): " show_tags

# Set defaults if not provided
blog_title=${blog_title:-"Blog"}
posts_per_page=${posts_per_page:-10}
show_excerpts=${show_excerpts:-"y"}
show_dates=${show_dates:-"y"}
show_tags=${show_tags:-"y"}

# Create blog.html
cat > "blog.html" << EOL
---
layout: default
title: "${blog_title}"
---

<h1 class="page-title">${blog_title}</h1>

<div class="post-list">
  {% for post in site.posts %}
  <div class="post-card">
    <h2 class="post-title"><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h2>
    
    {% if post.date and "${show_dates}" == "y" %}
    <div class="post-date">{{ post.date | date: "%B %d, %Y" }}</div>
    {% endif %}
    
    {% if "${show_excerpts}" == "y" %}
    <div class="post-excerpt">
      {% if post.excerpt %}
        {{ post.excerpt }}
      {% else %}
        {{ post.content | strip_html | truncatewords: 50 }}
      {% endif %}
    </div>
    {% endif %}
    
    {% if post.tags and "${show_tags}" == "y" %}
    <div class="post-tags">
      {% for tag in post.tags %}
      <a href="#">{{ tag }}</a>
      {% endfor %}
    </div>
    {% endif %}
    
    <a href="{{ post.url | relative_url }}" class="read-more">Read More</a>
  </div>
  {% endfor %}
</div>

<style>
  .page-title {
    text-align: center;
    margin-bottom: 40px;
  }
  
  .post-list {
    display: grid;
    grid-template-columns: 1fr;
    gap: 30px;
  }
  
  .post-card {
    background-color: rgba(255, 255, 255, 0.1);
    padding: 30px;
    border-radius: 5px;
    border: 2px solid rgba(255, 255, 255, 0.3);
    position: relative;
  }
  
  .post-title {
    margin-top: 0;
    margin-bottom: 10px;
  }
  
  .post-title a {
    color: #ffffff;
    text-decoration: none;
    transition: opacity 0.3s ease;
  }
  
  .post-title a:hover {
    opacity: 0.8;
  }
  
  .post-date {
    font-size: 0.9rem;
    margin-bottom: 15px;
    opacity: 0.8;
  }
  
  .post-excerpt {
    margin-bottom: 20px;
  }
  
  .post-tags {
    margin-bottom: 15px;
  }
  
  .post-tags a {
    display: inline-block;
    margin-right: 10px;
    font-size: 0.9rem;
    opacity: 0.8;
    transition: opacity 0.3s ease;
  }
  
  .post-tags a:hover {
    opacity: 1;
  }
  
  .read-more {
    display: inline-block;
    padding: 8px 15px;
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 4px;
    transition: background-color 0.3s ease;
    text-decoration: none;
    color: #ffffff;
  }
  
  .read-more:hover {
    background-color: rgba(255, 255, 255, 0.2);
  }
  
  @media (max-width: 768px) {
    .post-card {
      padding: 20px;
    }
  }
</style>
EOL

echo
echo "Blog index page created successfully!"
echo "File: blog.html"
echo
echo "To preview your site with the new blog index page, run:"
echo "bundle exec jekyll serve"
echo
echo "Would you like to open the blog index page in your default editor?"
read -p "Enter 'y' to open, any other key to exit: " open_editor

if [ "$open_editor" == "y" ]; then
    if [ -n "$EDITOR" ]; then
        $EDITOR "blog.html"
    elif command -v code &> /dev/null; then
        code "blog.html"
    elif command -v nano &> /dev/null; then
        nano "blog.html"
    elif command -v vim &> /dev/null; then
        vim "blog.html"
    else
        echo "No editor found. Please open the file manually."
    fi
fi

# Ask if the user wants to add the blog page to navigation
echo
echo "Would you like to add the blog page to the navigation menu in _config.yml?"
read -p "Enter 'y' to add, any other key to skip: " add_to_nav

if [ "$add_to_nav" == "y" ]; then
    # Check if navigation section exists
    if grep -q "navigation:" _config.yml; then
        # Check if Blog menu item already exists
        if grep -q "title: \"Blog\"" _config.yml; then
            echo "Blog menu item already exists in navigation."
        else
            # Add Blog menu item
            sed -i '' "/navigation:/,/^[^ ]/ s/^[^ ]/  - title: \"Blog\"\n    url: \"/blog.html\"\n&/" _config.yml
            echo "Added Blog menu item to navigation."
        fi
    else
        # Create new navigation section
        echo
        echo "No navigation section found in _config.yml."
        echo "Would you like to create a new navigation section with a Blog menu item?"
        read -p "Enter 'y' to create, any other key to skip: " create_nav
        
        if [ "$create_nav" == "y" ]; then
            # Create new navigation section
            cat >> _config.yml << EOL

# Navigation
navigation:
  - title: "Home"
    url: "/"
  - title: "Blog"
    url: "/blog.html"
EOL
            echo "Created new navigation section with Blog menu item."
        else
            echo "Navigation not updated."
        fi
    fi
fi

echo "Done!"
