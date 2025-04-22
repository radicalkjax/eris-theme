#!/bin/bash

# Eris Theme - Test Script
# This script helps users test the Eris theme locally

echo "Eris Theme Test Script"
echo "====================="
echo

# Check if Jekyll is installed
if ! command -v jekyll &> /dev/null; then
    echo "Jekyll is not installed. Please install Jekyll first:"
    echo "gem install jekyll bundler"
    exit 1
fi

# Check if we're in the eris-theme directory
if [ ! -f "eris-theme.gemspec" ]; then
    echo "Error: This script must be run from the eris-theme directory."
    echo "Please navigate to the eris-theme directory and try again."
    exit 1
fi

# Create a temporary test site
echo "Creating a temporary test site..."
temp_dir="_theme_test"

# Remove existing test directory if it exists
if [ -d "$temp_dir" ]; then
    echo "Removing existing test directory..."
    rm -rf "$temp_dir"
fi

# Create the test directory
mkdir -p "$temp_dir"
cd "$temp_dir"

# Create a minimal Jekyll site
echo "Setting up a minimal Jekyll site..."

# Create Gemfile
cat > Gemfile << EOL
source "https://rubygems.org"

gem "jekyll", "~> 4.2"
gem "eris-theme", path: ".."
EOL

# Create _config.yml
cat > _config.yml << EOL
title: Eris Theme Test
description: A test site for the Eris theme
theme: eris-theme

# Navigation
navigation:
  - title: Home
    url: /
  - title: About
    url: /about.html
  - title: Blog
    url: /blog.html

# Theme color settings
theme_color:
  primary: "#6d105a"
  text: "#ffffff"

# Social media links
social:
  bluesky: https://bsky.app/profile/test
  linkedin: https://www.linkedin.com/in/test
  instagram: https://www.instagram.com/test
  github: https://github.com/test
EOL

# Create index.html
cat > index.html << EOL
---
layout: default
title: Home
---

<div class="post-card">
  <h1 class="post-title">Welcome to Eris Theme Test</h1>
  <div class="post-content">
    <p>This is a test site for the Eris theme. If you can see this page with proper styling, the theme is working correctly!</p>
    
    <h2>Theme Features</h2>
    <ul>
      <li>Responsive design</li>
      <li>Distinctive purple color scheme</li>
      <li>Unique border styling</li>
      <li>Dropdown navigation</li>
      <li>Social media integration</li>
      <li>Mermaid diagram support</li>
    </ul>
    
    <h2>Mermaid Diagram Example</h2>
    
    <div class="mermaid">
      graph TD
        A[Jekyll Site] --> B[Eris Theme]
        B --> C[Layouts]
        B --> D[Includes]
        B --> E[Sass Styling]
        B --> F[JavaScript]
    </div>
  </div>
</div>
EOL

# Create about.html
cat > about.html << EOL
---
layout: default
title: About
---

<div class="post-card">
  <h1 class="post-title">About Eris Theme</h1>
  <div class="post-content">
    <p>Eris is a modern, minimalist Jekyll theme with a distinctive purple color scheme and unique border styling.</p>
    <p>This is a test page to demonstrate the theme's styling and features.</p>
  </div>
</div>
EOL

# Create blog.html
cat > blog.html << EOL
---
layout: default
title: Blog
---

<h1 class="page-title">Blog</h1>

<div class="post-list">
  {% for post in site.posts %}
  <div class="post-card">
    <h2 class="post-title"><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h2>
    <div class="post-date">{{ post.date | date: "%B %d, %Y" }}</div>
    <div class="post-excerpt">{{ post.excerpt }}</div>
    <a href="{{ post.url | relative_url }}" class="read-more">Read More</a>
  </div>
  {% endfor %}
</div>
EOL

# Create _posts directory and a sample post
mkdir -p _posts
cat > _posts/$(date +%Y-%m-%d)-welcome-to-eris.md << EOL
---
layout: post
title: "Welcome to Eris Theme"
date: $(date +%Y-%m-%d) 12:00:00 -0700
categories: jekyll theme
tags: [jekyll, theme, eris]
---

This is a sample post to demonstrate the Eris theme's post styling.

## Heading 2

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a diam lectus. Sed sit amet ipsum mauris.

### Heading 3

Maecenas congue ligula ac quam viverra nec consectetur ante hendrerit.

#### Heading 4

Donec et mollis dolor. Praesent et diam eget libero egestas mattis sit amet vitae augue.

##### Heading 5

Nam tincidunt congue enim, ut porta lorem lacinia consectetur.

###### Heading 6

Donec ut libero sed arcu vehicula ultricies a non tortor.

**Bold text** and *italic text* and \`inline code\`.

> This is a blockquote. Lorem ipsum dolor sit amet, consectetur adipiscing elit.

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
EOL

# Install dependencies
echo "Installing dependencies..."
bundle install

# Start Jekyll server
echo "Starting Jekyll server..."
echo "You can view the test site at http://localhost:4000"
echo "Press Ctrl+C to stop the server when you're done testing."
echo

bundle exec jekyll serve
