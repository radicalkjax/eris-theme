#!/bin/bash

# Eris Theme - Create Blog Post Script
# This script helps users create a new blog post for their Jekyll site

echo "Eris Theme - Create Blog Post"
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

# Check if _posts directory exists
if [ ! -d "_posts" ]; then
    mkdir -p _posts
    echo "Created _posts directory."
fi

# Get post details
echo
echo "Enter the details for your new blog post:"
read -p "Title: " post_title
read -p "Categories (comma-separated, e.g., jekyll,theme): " post_categories
read -p "Tags (comma-separated, e.g., jekyll,theme,eris): " post_tags

# Format categories and tags
if [ -n "$post_categories" ]; then
    formatted_categories=$(echo $post_categories | tr ',' ' ')
else
    formatted_categories="jekyll theme"
fi

if [ -n "$post_tags" ]; then
    formatted_tags="[$(echo $post_tags | tr ',' ', ')]"
else
    formatted_tags="[jekyll, theme, eris]"
fi

# Generate filename
post_date=$(date +%Y-%m-%d)
post_title_slug=$(echo "$post_title" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-')
post_filename="_posts/${post_date}-${post_title_slug}.md"

# Check if file already exists
if [ -f "$post_filename" ]; then
    echo "Error: A post with this title already exists for today's date."
    echo "Please choose a different title or edit the existing post."
    exit 1
fi

# Create post file
cat > "$post_filename" << EOL
---
layout: post
title: "${post_title}"
date: ${post_date} $(date +%H:%M:%S) $(date +%z)
categories: ${formatted_categories}
tags: ${formatted_tags}
---

Write your post content here. This is a Markdown file, so you can use Markdown syntax to format your content.

## Heading 2

Regular paragraph text.

### Heading 3

More content...

**Bold text** and *italic text*.

> This is a blockquote.

\`\`\`
// This is a code block
function helloWorld() {
  console.log("Hello, world!");
}
\`\`\`

\`\`\`mermaid
graph TD
    A[Start] --> B[Process]
    B --> C[End]
\`\`\`

- Unordered list item 1
- Unordered list item 2
- Unordered list item 3

1. Ordered list item 1
2. Ordered list item 2
3. Ordered list item 3

[Link text](https://example.com)

![Image alt text](https://example.com/image.jpg)
EOL

echo
echo "Blog post created successfully!"
echo "File: $post_filename"
echo
echo "To preview your site with the new post, run:"
echo "bundle exec jekyll serve"
echo
echo "Would you like to open the post in your default editor?"
read -p "Enter 'y' to open, any other key to exit: " open_editor

if [ "$open_editor" == "y" ]; then
    if [ -n "$EDITOR" ]; then
        $EDITOR "$post_filename"
    elif command -v code &> /dev/null; then
        code "$post_filename"
    elif command -v nano &> /dev/null; then
        nano "$post_filename"
    elif command -v vim &> /dev/null; then
        vim "$post_filename"
    else
        echo "No editor found. Please open the file manually."
    fi
fi

echo "Done!"
