#!/bin/bash

# Eris Theme - Create Contact Page Script
# This script helps users create a contact page for their Jekyll site

echo "Eris Theme - Create Contact Page"
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

# Check if contact.html already exists
if [ -f "contact.html" ]; then
    echo "contact.html already exists."
    read -p "Would you like to overwrite it? (y/n): " overwrite_contact
    if [ "$overwrite_contact" != "y" ]; then
        echo "No changes made to contact.html."
        exit 0
    fi
fi

# Get contact details
echo
echo "Enter your contact details:"
read -p "Email (optional): " contact_email
read -p "Twitter/X (optional): " contact_twitter
read -p "LinkedIn (optional): " contact_linkedin
read -p "GitHub (optional): " contact_github
read -p "Instagram (optional): " contact_instagram
read -p "BlueSky (optional): " contact_bluesky

# Create contact.html
cat > "contact.html" << EOL
---
layout: default
title: "Contact"
---

<div class="post-card">
  <h1 class="post-title">Contact</h1>
  
  <div class="post-content">
    <p>Get in touch with me through any of the following methods:</p>
    
    <div class="contact-methods">
      ${contact_email:+<div class="contact-method">
        <i class="fas fa-envelope"></i>
        <h3>Email</h3>
        <p><a href="mailto:$contact_email">$contact_email</a></p>
      </div>}
      
      ${contact_twitter:+<div class="contact-method">
        <i class="fab fa-twitter"></i>
        <h3>Twitter/X</h3>
        <p><a href="https://twitter.com/$contact_twitter" target="_blank">@$contact_twitter</a></p>
      </div>}
      
      ${contact_linkedin:+<div class="contact-method">
        <i class="fab fa-linkedin"></i>
        <h3>LinkedIn</h3>
        <p><a href="$contact_linkedin" target="_blank">LinkedIn Profile</a></p>
      </div>}
      
      ${contact_github:+<div class="contact-method">
        <i class="fab fa-github"></i>
        <h3>GitHub</h3>
        <p><a href="$contact_github" target="_blank">GitHub Profile</a></p>
      </div>}
      
      ${contact_instagram:+<div class="contact-method">
        <i class="fab fa-instagram"></i>
        <h3>Instagram</h3>
        <p><a href="$contact_instagram" target="_blank">Instagram Profile</a></p>
      </div>}
      
      ${contact_bluesky:+<div class="contact-method">
        <i class="fas fa-butterfly"></i>
        <h3>BlueSky</h3>
        <p><a href="$contact_bluesky" target="_blank">BlueSky Profile</a></p>
      </div>}
    </div>
    
    <h2>Contact Form</h2>
    <p>Or send me a message using the form below:</p>
    
    <form class="contact-form" action="https://formspree.io/f/your-formspree-endpoint" method="POST">
      <div class="form-group">
        <label for="name">Name</label>
        <input type="text" id="name" name="name" required>
      </div>
      
      <div class="form-group">
        <label for="email">Email</label>
        <input type="email" id="email" name="_replyto" required>
      </div>
      
      <div class="form-group">
        <label for="subject">Subject</label>
        <input type="text" id="subject" name="subject" required>
      </div>
      
      <div class="form-group">
        <label for="message">Message</label>
        <textarea id="message" name="message" rows="5" required></textarea>
      </div>
      
      <button type="submit" class="form-button">Send Message</button>
    </form>
    
    <div class="form-note">
      <p><strong>Note:</strong> To make this contact form work, you need to:</p>
      <ol>
        <li>Create a free account at <a href="https://formspree.io" target="_blank">Formspree</a></li>
        <li>Set up a new form and get your endpoint</li>
        <li>Replace "your-formspree-endpoint" in the form action with your actual endpoint</li>
      </ol>
    </div>
  </div>
</div>

<style>
  .contact-methods {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 20px;
    margin: 30px 0;
  }
  
  .contact-method {
    background-color: rgba(255, 255, 255, 0.1);
    padding: 20px;
    border-radius: 5px;
    text-align: center;
  }
  
  .contact-method i {
    font-size: 2rem;
    margin-bottom: 10px;
  }
  
  .contact-form {
    margin: 30px 0;
  }
  
  .form-group {
    margin-bottom: 20px;
  }
  
  .form-group label {
    display: block;
    margin-bottom: 5px;
  }
  
  .form-group input,
  .form-group textarea {
    width: 100%;
    padding: 10px;
    background-color: rgba(255, 255, 255, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.3);
    border-radius: 5px;
    color: #ffffff;
  }
  
  .form-button {
    background-color: #6d105a;
    color: #ffffff;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    font-size: 1rem;
  }
  
  .form-button:hover {
    background-color: #8a1372;
  }
  
  .form-note {
    margin-top: 30px;
    padding: 15px;
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 5px;
  }
</style>
EOL

echo
echo "Contact page created successfully!"
echo "File: contact.html"
echo
echo "To preview your site with the new contact page, run:"
echo "bundle exec jekyll serve"
echo
echo "Would you like to open the contact page in your default editor?"
read -p "Enter 'y' to open, any other key to exit: " open_editor

if [ "$open_editor" == "y" ]; then
    if [ -n "$EDITOR" ]; then
        $EDITOR "contact.html"
    elif command -v code &> /dev/null; then
        code "contact.html"
    elif command -v nano &> /dev/null; then
        nano "contact.html"
    elif command -v vim &> /dev/null; then
        vim "contact.html"
    else
        echo "No editor found. Please open the file manually."
    fi
fi

# Ask if the user wants to add the contact page to navigation
echo
echo "Would you like to add the contact page to the navigation menu in _config.yml?"
read -p "Enter 'y' to add, any other key to skip: " add_to_nav

if [ "$add_to_nav" == "y" ]; then
    # Check if navigation section exists
    if grep -q "navigation:" _config.yml; then
        # Check if Contact menu item already exists
        if grep -q "title: \"Contact\"" _config.yml; then
            echo "Contact menu item already exists in navigation."
        else
            # Add Contact menu item
            sed -i '' "/navigation:/,/^[^ ]/ s/^[^ ]/  - title: \"Contact\"\n    url: \"/contact.html\"\n&/" _config.yml
            echo "Added Contact menu item to navigation."
        fi
    else
        # Create new navigation section
        echo
        echo "No navigation section found in _config.yml."
        echo "Would you like to create a new navigation section with a Contact menu item?"
        read -p "Enter 'y' to create, any other key to skip: " create_nav
        
        if [ "$create_nav" == "y" ]; then
            # Create new navigation section
            cat >> _config.yml << EOL

# Navigation
navigation:
  - title: "Home"
    url: "/"
  - title: "Contact"
    url: "/contact.html"
EOL
            echo "Created new navigation section with Contact menu item."
        else
            echo "Navigation not updated."
        fi
    fi
fi

echo
echo "Important: To make the contact form work, you need to:"
echo "1. Create a free account at https://formspree.io"
echo "2. Set up a new form and get your endpoint"
echo "3. Replace \"your-formspree-endpoint\" in the form action with your actual endpoint"
echo
echo "Done!"
