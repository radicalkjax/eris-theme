#!/bin/bash

# Eris Theme - Create About Page Script
# This script helps users create an about page for their Jekyll site

echo "Eris Theme - Create About Page"
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

# Check if about.html already exists
if [ -f "about.html" ]; then
    echo "about.html already exists."
    read -p "Would you like to overwrite it? (y/n): " overwrite_about
    if [ "$overwrite_about" != "y" ]; then
        echo "No changes made to about.html."
        exit 0
    fi
fi

# Get about page details
echo
echo "Enter the details for your about page:"
read -p "Your Name: " your_name
read -p "Your Title/Role (e.g., Software Developer): " your_title
read -p "Your Bio (a short paragraph about yourself): " your_bio
read -p "Your Photo URL (optional): " your_photo
read -p "Include skills section? (y/n, default: y): " include_skills
read -p "Include experience section? (y/n, default: y): " include_experience
read -p "Include education section? (y/n, default: y): " include_education

# Set defaults if not provided
your_name=${your_name:-"Your Name"}
your_title=${your_title:-"Your Title/Role"}
your_bio=${your_bio:-"This is a short bio about yourself. You can write about your background, interests, and goals here."}
include_skills=${include_skills:-"y"}
include_experience=${include_experience:-"y"}
include_education=${include_education:-"y"}

# Create about.html
cat > "about.html" << EOL
---
layout: default
title: "About"
---

<div class="post-card">
  <h1 class="post-title">About Me</h1>
  
  <div class="post-content">
    <div class="about-header">
      ${your_photo:+<div class="about-photo">
        <img src="$your_photo" alt="$your_name">
      </div>}
      
      <div class="about-intro">
        <h2>${your_name}</h2>
        <h3>${your_title}</h3>
        <p>${your_bio}</p>
      </div>
    </div>
    
    {% if "${include_skills}" == "y" %}
    <div class="about-section">
      <h2 class="section-title">Skills</h2>
      
      <div class="skills-container">
        <div class="skill-category">
          <h3>Technical Skills</h3>
          <ul>
            <li>Skill 1</li>
            <li>Skill 2</li>
            <li>Skill 3</li>
            <li>Skill 4</li>
            <li>Skill 5</li>
          </ul>
        </div>
        
        <div class="skill-category">
          <h3>Soft Skills</h3>
          <ul>
            <li>Skill 1</li>
            <li>Skill 2</li>
            <li>Skill 3</li>
            <li>Skill 4</li>
            <li>Skill 5</li>
          </ul>
        </div>
      </div>
    </div>
    {% endif %}
    
    {% if "${include_experience}" == "y" %}
    <div class="about-section">
      <h2 class="section-title">Experience</h2>
      
      <div class="timeline">
        <div class="timeline-item">
          <div class="timeline-date">2023 - Present</div>
          <div class="timeline-content">
            <h3>Job Title</h3>
            <h4>Company Name</h4>
            <p>Description of your responsibilities and achievements in this role.</p>
          </div>
        </div>
        
        <div class="timeline-item">
          <div class="timeline-date">2020 - 2023</div>
          <div class="timeline-content">
            <h3>Job Title</h3>
            <h4>Company Name</h4>
            <p>Description of your responsibilities and achievements in this role.</p>
          </div>
        </div>
        
        <div class="timeline-item">
          <div class="timeline-date">2018 - 2020</div>
          <div class="timeline-content">
            <h3>Job Title</h3>
            <h4>Company Name</h4>
            <p>Description of your responsibilities and achievements in this role.</p>
          </div>
        </div>
      </div>
    </div>
    {% endif %}
    
    {% if "${include_education}" == "y" %}
    <div class="about-section">
      <h2 class="section-title">Education</h2>
      
      <div class="timeline">
        <div class="timeline-item">
          <div class="timeline-date">2014 - 2018</div>
          <div class="timeline-content">
            <h3>Degree Name</h3>
            <h4>University Name</h4>
            <p>Description of your studies, achievements, and any relevant projects or activities.</p>
          </div>
        </div>
        
        <div class="timeline-item">
          <div class="timeline-date">2010 - 2014</div>
          <div class="timeline-content">
            <h3>Degree Name</h3>
            <h4>University Name</h4>
            <p>Description of your studies, achievements, and any relevant projects or activities.</p>
          </div>
        </div>
      </div>
    </div>
    {% endif %}
    
    <div class="about-section">
      <h2 class="section-title">Get In Touch</h2>
      <p>Interested in working together or have a question? Feel free to reach out!</p>
      <a href="/contact.html" class="button">Contact Me</a>
    </div>
  </div>
</div>

<style>
  .about-header {
    display: flex;
    flex-wrap: wrap;
    gap: 30px;
    margin-bottom: 40px;
  }
  
  .about-photo {
    flex: 0 0 200px;
  }
  
  .about-photo img {
    width: 100%;
    border-radius: 5px;
    border: 2px solid rgba(255, 255, 255, 0.3);
  }
  
  .about-intro {
    flex: 1;
    min-width: 300px;
  }
  
  .about-intro h2 {
    margin-top: 0;
    margin-bottom: 10px;
  }
  
  .about-intro h3 {
    margin-top: 0;
    margin-bottom: 20px;
    opacity: 0.8;
  }
  
  .about-section {
    margin-bottom: 40px;
  }
  
  .section-title {
    position: relative;
    margin-bottom: 30px;
  }
  
  .section-title::after {
    content: '';
    display: block;
    width: 50px;
    height: 3px;
    background-color: #6d105a;
    margin-top: 10px;
  }
  
  .skills-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 30px;
  }
  
  .skill-category {
    background-color: rgba(255, 255, 255, 0.1);
    padding: 20px;
    border-radius: 5px;
    border: 1px solid rgba(255, 255, 255, 0.2);
  }
  
  .skill-category h3 {
    margin-top: 0;
    margin-bottom: 15px;
  }
  
  .timeline {
    position: relative;
  }
  
  .timeline::before {
    content: '';
    position: absolute;
    top: 0;
    bottom: 0;
    left: 120px;
    width: 2px;
    background-color: rgba(255, 255, 255, 0.2);
  }
  
  .timeline-item {
    position: relative;
    margin-bottom: 30px;
    padding-left: 150px;
  }
  
  .timeline-date {
    position: absolute;
    left: 0;
    top: 0;
    width: 100px;
    text-align: right;
    padding-right: 20px;
    font-weight: bold;
  }
  
  .timeline-content {
    background-color: rgba(255, 255, 255, 0.1);
    padding: 20px;
    border-radius: 5px;
    border: 1px solid rgba(255, 255, 255, 0.2);
  }
  
  .timeline-content h3 {
    margin-top: 0;
    margin-bottom: 5px;
  }
  
  .timeline-content h4 {
    margin-top: 0;
    margin-bottom: 15px;
    opacity: 0.8;
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
  
  @media (max-width: 768px) {
    .about-header {
      flex-direction: column;
      align-items: center;
      text-align: center;
    }
    
    .about-photo {
      flex: 0 0 150px;
    }
    
    .timeline::before {
      left: 20px;
    }
    
    .timeline-item {
      padding-left: 50px;
    }
    
    .timeline-date {
      position: relative;
      left: auto;
      top: auto;
      width: auto;
      text-align: left;
      padding-right: 0;
      margin-bottom: 10px;
      padding-left: 30px;
    }
    
    .timeline-date::before {
      content: '';
      position: absolute;
      left: 0;
      top: 50%;
      width: 20px;
      height: 2px;
      background-color: rgba(255, 255, 255, 0.2);
    }
  }
</style>
EOL

echo
echo "About page created successfully!"
echo "File: about.html"
echo
echo "To preview your site with the new about page, run:"
echo "bundle exec jekyll serve"
echo
echo "Would you like to open the about page in your default editor?"
read -p "Enter 'y' to open, any other key to exit: " open_editor

if [ "$open_editor" == "y" ]; then
    if [ -n "$EDITOR" ]; then
        $EDITOR "about.html"
    elif command -v code &> /dev/null; then
        code "about.html"
    elif command -v nano &> /dev/null; then
        nano "about.html"
    elif command -v vim &> /dev/null; then
        vim "about.html"
    else
        echo "No editor found. Please open the file manually."
    fi
fi

# Ask if the user wants to add the about page to navigation
echo
echo "Would you like to add the about page to the navigation menu in _config.yml?"
read -p "Enter 'y' to add, any other key to skip: " add_to_nav

if [ "$add_to_nav" == "y" ]; then
    # Check if navigation section exists
    if grep -q "navigation:" _config.yml; then
        # Check if About menu item already exists
        if grep -q "title: \"About\"" _config.yml; then
            echo "About menu item already exists in navigation."
        else
            # Add About menu item
            sed -i '' "/navigation:/,/^[^ ]/ s/^[^ ]/  - title: \"About\"\n    url: \"/about.html\"\n&/" _config.yml
            echo "Added About menu item to navigation."
        fi
    else
        # Create new navigation section
        echo
        echo "No navigation section found in _config.yml."
        echo "Would you like to create a new navigation section with an About menu item?"
        read -p "Enter 'y' to create, any other key to skip: " create_nav
        
        if [ "$create_nav" == "y" ]; then
            # Create new navigation section
            cat >> _config.yml << EOL

# Navigation
navigation:
  - title: "Home"
    url: "/"
  - title: "About"
    url: "/about.html"
EOL
            echo "Created new navigation section with About menu item."
        else
            echo "Navigation not updated."
        fi
    fi
fi

# Check if contact.html exists
if [ ! -f "contact.html" ] && grep -q "href=\"/contact.html\"" about.html; then
    echo
    echo "Your about page references contact.html, but this file does not exist yet."
    echo "You can create it using the create-contact.sh script."
fi

echo "Done!"
