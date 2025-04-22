#!/bin/bash

# Eris Theme - Create Home Page Script
# This script helps users create a home page for their Jekyll site

echo "Eris Theme - Create Home Page"
echo "==========================="
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

# Check if index.html already exists
if [ -f "index.html" ]; then
    echo "index.html already exists."
    read -p "Would you like to overwrite it? (y/n): " overwrite_index
    if [ "$overwrite_index" != "y" ]; then
        echo "No changes made to index.html."
        exit 0
    fi
fi

# Get home page details
echo
echo "Enter the details for your home page:"
read -p "Site Title (default: My Website): " site_title
read -p "Tagline (default: Welcome to my website): " tagline
read -p "Show featured posts? (y/n, default: y): " show_featured
read -p "Number of featured posts (default: 3): " featured_count
read -p "Show about section? (y/n, default: y): " show_about
read -p "About text: " about_text
read -p "Show projects section? (y/n, default: y): " show_projects
read -p "Show contact section? (y/n, default: y): " show_contact

# Set defaults if not provided
site_title=${site_title:-"My Website"}
tagline=${tagline:-"Welcome to my website"}
show_featured=${show_featured:-"y"}
featured_count=${featured_count:-3}
show_about=${show_about:-"y"}
about_text=${about_text:-"This is the about section of my website. You can write a brief introduction about yourself or your website here."}
show_projects=${show_projects:-"y"}
show_contact=${show_contact:-"y"}

# Create index.html
cat > "index.html" << EOL
---
layout: default
title: "Home"
---

<div class="home-hero">
  <h1 class="site-title">${site_title}</h1>
  <p class="site-tagline">${tagline}</p>
</div>

{% if "${show_about}" == "y" %}
<div class="home-section">
  <h2 class="section-title">About</h2>
  <div class="section-content">
    <p>${about_text}</p>
    <a href="/about.html" class="button">Learn More</a>
  </div>
</div>
{% endif %}

{% if "${show_featured}" == "y" %}
<div class="home-section">
  <h2 class="section-title">Latest Posts</h2>
  <div class="featured-posts">
    {% for post in site.posts limit:${featured_count} %}
    <div class="featured-post">
      <h3 class="post-title"><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
      <div class="post-date">{{ post.date | date: "%B %d, %Y" }}</div>
      <div class="post-excerpt">{{ post.excerpt | strip_html | truncatewords: 30 }}</div>
      <a href="{{ post.url | relative_url }}" class="read-more">Read More</a>
    </div>
    {% endfor %}
  </div>
  <div class="section-footer">
    <a href="/blog.html" class="button">View All Posts</a>
  </div>
</div>
{% endif %}

{% if "${show_projects}" == "y" %}
<div class="home-section">
  <h2 class="section-title">Projects</h2>
  <div class="featured-projects">
    {% assign project_files = site.html_files | where_exp: "file", "file.path contains '/projects/'" | limit: 3 %}
    {% for project in project_files %}
    <div class="featured-project">
      <h3 class="project-title"><a href="{{ project.path | relative_url }}">{{ project.title }}</a></h3>
      <a href="{{ project.path | relative_url }}" class="button">View Project</a>
    </div>
    {% endfor %}
  </div>
  <div class="section-footer">
    <a href="/projects.html" class="button">View All Projects</a>
  </div>
</div>
{% endif %}

{% if "${show_contact}" == "y" %}
<div class="home-section">
  <h2 class="section-title">Get In Touch</h2>
  <div class="section-content">
    <p>Have a question or want to work together? Feel free to reach out!</p>
    <a href="/contact.html" class="button">Contact Me</a>
  </div>
</div>
{% endif %}

<style>
  .home-hero {
    text-align: center;
    padding: 60px 0;
    margin-bottom: 40px;
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 5px;
  }
  
  .site-title {
    font-size: 3rem;
    margin-bottom: 20px;
  }
  
  .site-tagline {
    font-size: 1.5rem;
    opacity: 0.8;
  }
  
  .home-section {
    margin-bottom: 60px;
  }
  
  .section-title {
    text-align: center;
    margin-bottom: 30px;
    position: relative;
  }
  
  .section-title::after {
    content: '';
    display: block;
    width: 50px;
    height: 3px;
    background-color: #6d105a;
    margin: 15px auto 0;
  }
  
  .section-content {
    text-align: center;
    max-width: 800px;
    margin: 0 auto;
  }
  
  .featured-posts, .featured-projects {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 30px;
    margin-bottom: 30px;
  }
  
  .featured-post, .featured-project {
    background-color: rgba(255, 255, 255, 0.1);
    padding: 20px;
    border-radius: 5px;
    border: 1px solid rgba(255, 255, 255, 0.2);
  }
  
  .post-title, .project-title {
    margin-top: 0;
    margin-bottom: 10px;
  }
  
  .post-title a, .project-title a {
    color: #ffffff;
    text-decoration: none;
    transition: opacity 0.3s ease;
  }
  
  .post-title a:hover, .project-title a:hover {
    opacity: 0.8;
  }
  
  .post-date {
    font-size: 0.9rem;
    margin-bottom: 10px;
    opacity: 0.8;
  }
  
  .post-excerpt {
    margin-bottom: 15px;
  }
  
  .read-more {
    display: inline-block;
    padding: 5px 10px;
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 3px;
    text-decoration: none;
    color: #ffffff;
    transition: background-color 0.3s ease;
  }
  
  .read-more:hover {
    background-color: rgba(255, 255, 255, 0.2);
  }
  
  .button {
    display: inline-block;
    padding: 10px 20px;
    background-color: #6d105a;
    color: #ffffff;
    text-decoration: none;
    border-radius: 5px;
    transition: background-color 0.3s ease;
  }
  
  .button:hover {
    background-color: #8a1372;
  }
  
  .section-footer {
    text-align: center;
    margin-top: 20px;
  }
  
  @media (max-width: 768px) {
    .featured-posts, .featured-projects {
      grid-template-columns: 1fr;
    }
    
    .site-title {
      font-size: 2.5rem;
    }
    
    .site-tagline {
      font-size: 1.2rem;
    }
  }
</style>
EOL

echo
echo "Home page created successfully!"
echo "File: index.html"
echo
echo "To preview your site with the new home page, run:"
echo "bundle exec jekyll serve"
echo
echo "Would you like to open the home page in your default editor?"
read -p "Enter 'y' to open, any other key to exit: " open_editor

if [ "$open_editor" == "y" ]; then
    if [ -n "$EDITOR" ]; then
        $EDITOR "index.html"
    elif command -v code &> /dev/null; then
        code "index.html"
    elif command -v nano &> /dev/null; then
        nano "index.html"
    elif command -v vim &> /dev/null; then
        vim "index.html"
    else
        echo "No editor found. Please open the file manually."
    fi
fi

# Check if the user needs to create the referenced pages
echo
echo "Your home page references the following pages that may not exist yet:"

missing_pages=0

if [ "${show_about}" == "y" ] && [ ! -f "about.html" ]; then
    echo "- about.html (About page)"
    missing_pages=$((missing_pages + 1))
fi

if [ "${show_featured}" == "y" ] && [ ! -f "blog.html" ]; then
    echo "- blog.html (Blog index page)"
    missing_pages=$((missing_pages + 1))
fi

if [ "${show_projects}" == "y" ] && [ ! -f "projects.html" ]; then
    echo "- projects.html (Projects index page)"
    missing_pages=$((missing_pages + 1))
fi

if [ "${show_contact}" == "y" ] && [ ! -f "contact.html" ]; then
    echo "- contact.html (Contact page)"
    missing_pages=$((missing_pages + 1))
fi

if [ $missing_pages -gt 0 ]; then
    echo
    echo "You can create these pages using the following scripts:"
    
    if [ "${show_about}" == "y" ] && [ ! -f "about.html" ]; then
        echo "- create-page.sh (for about.html)"
    fi
    
    if [ "${show_featured}" == "y" ] && [ ! -f "blog.html" ]; then
        echo "- create-blog-index.sh (for blog.html)"
    fi
    
    if [ "${show_projects}" == "y" ] && [ ! -f "projects.html" ]; then
        echo "- create-project.sh (for projects.html)"
    fi
    
    if [ "${show_contact}" == "y" ] && [ ! -f "contact.html" ]; then
        echo "- create-contact.sh (for contact.html)"
    fi
fi

echo "Done!"
