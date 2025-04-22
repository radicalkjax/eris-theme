#!/bin/bash

# Eris Theme - Create Project Page Script
# This script helps users create a new project page for their Jekyll site

echo "Eris Theme - Create Project Page"
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

# Check if projects directory exists
if [ ! -d "projects" ]; then
    mkdir -p projects
    echo "Created projects directory."
fi

# Get project details
echo
echo "Enter the details for your new project page:"
read -p "Project Title: " project_title
read -p "Project URL (e.g., project-name.html): " project_url

# Check if URL is provided
if [ -z "$project_url" ]; then
    # Generate URL from title
    project_url=$(echo "$project_title" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-').html
    echo "Generated URL: $project_url"
fi

# Check if file already exists
if [ -f "projects/$project_url" ]; then
    echo "Error: A project with this URL already exists."
    echo "Please choose a different URL or edit the existing project."
    exit 1
fi

# Get more project details
read -p "Project Description: " project_description
read -p "Project Image URL (optional): " project_image
read -p "Project GitHub URL (optional): " project_github
read -p "Project Demo URL (optional): " project_demo
read -p "Project Technologies (comma-separated, e.g., HTML,CSS,JavaScript): " project_technologies

# Format technologies
if [ -n "$project_technologies" ]; then
    formatted_technologies=$(echo $project_technologies | tr ',' ', ')
else
    formatted_technologies="HTML, CSS, JavaScript"
fi

# Create project file
cat > "projects/$project_url" << EOL
---
layout: default
title: "${project_title}"
---

<div class="post-card">
  <h1 class="post-title">${project_title}</h1>
  
  <div class="post-content">
    <p>${project_description}</p>
    
    <div class="project-details">
      <div class="project-image">
        ${project_image:+<img src="$project_image" alt="$project_title">}
      </div>
      
      <div class="project-info">
        <h2>Project Details</h2>
        
        <div class="project-technologies">
          <h3>Technologies Used</h3>
          <ul>
            $(for tech in $(echo $project_technologies | tr ',' ' '); do echo "            <li>$tech</li>"; done)
          </ul>
        </div>
        
        <div class="project-links">
          ${project_github:+<a href="$project_github" class="project-link" target="_blank"><i class="fab fa-github"></i> View on GitHub</a>}
          ${project_demo:+<a href="$project_demo" class="project-link" target="_blank"><i class="fas fa-external-link-alt"></i> Live Demo</a>}
        </div>
      </div>
    </div>
    
    <h2>Project Overview</h2>
    <p>Write your project overview here. This is an HTML file, so you can use HTML tags to format your content.</p>
    
    <h2>Features</h2>
    <ul>
      <li>Feature 1</li>
      <li>Feature 2</li>
      <li>Feature 3</li>
    </ul>
    
    <h2>Implementation</h2>
    <p>Describe how you implemented the project here.</p>
    
    <h3>Technical Challenges</h3>
    <p>Describe any technical challenges you faced and how you overcame them.</p>
    
    <h3>Code Snippets</h3>
    <pre><code>
// Example code snippet
function exampleFunction() {
  console.log("This is an example code snippet.");
}
    </code></pre>
    
    <h2>Future Improvements</h2>
    <p>Describe any future improvements you plan to make to the project.</p>
    
    <div class="mermaid">
      graph TD
        A[Project Structure] --> B[Component 1]
        A --> C[Component 2]
        A --> D[Component 3]
        B --> E[Subcomponent 1.1]
        B --> F[Subcomponent 1.2]
    </div>
  </div>
</div>
EOL

echo
echo "Project page created successfully!"
echo "File: projects/$project_url"
echo
echo "To preview your site with the new project page, run:"
echo "bundle exec jekyll serve"
echo
echo "Would you like to open the project page in your default editor?"
read -p "Enter 'y' to open, any other key to exit: " open_editor

if [ "$open_editor" == "y" ]; then
    if [ -n "$EDITOR" ]; then
        $EDITOR "projects/$project_url"
    elif command -v code &> /dev/null; then
        code "projects/$project_url"
    elif command -v nano &> /dev/null; then
        nano "projects/$project_url"
    elif command -v vim &> /dev/null; then
        vim "projects/$project_url"
    else
        echo "No editor found. Please open the file manually."
    fi
fi

# Ask if the user wants to add the project to navigation
echo
echo "Would you like to add this project to the navigation menu in _config.yml?"
read -p "Enter 'y' to add, any other key to skip: " add_to_nav

if [ "$add_to_nav" == "y" ]; then
    # Check if navigation section exists
    if grep -q "navigation:" _config.yml; then
        # Check if Projects menu item exists
        if grep -q "title: \"Projects\"" _config.yml; then
            # Check if Projects menu item has a submenu
            if grep -A 1 "title: \"Projects\"" _config.yml | grep -q "submenu:"; then
                # Add to existing Projects submenu
                page_path="/projects/$project_url"
                sed -i '' "/title: \"Projects\"/,/^[^ ]/ s/^[^ ]/      - title: \"$project_title\"\n        url: \"$page_path\"\n&/" _config.yml
                echo "Added \"$project_title\" to Projects submenu."
            else
                # Create Projects submenu
                page_path="/projects/$project_url"
                sed -i '' "/title: \"Projects\"/,/^[^ ]/ s/^[^ ]/    submenu:\n      - title: \"$project_title\"\n        url: \"$page_path\"\n&/" _config.yml
                echo "Created Projects submenu with \"$project_title\"."
            fi
        else
            # Add Projects menu item with submenu
            echo
            echo "Projects menu item not found in navigation."
            read -p "Would you like to add a Projects menu item? (y/n): " add_projects
            
            if [ "$add_projects" == "y" ]; then
                # Add Projects menu item with submenu
                page_path="/projects/$project_url"
                sed -i '' "/navigation:/,/^[^ ]/ s/^[^ ]/  - title: \"Projects\"\n    url: \"/projects.html\"\n    submenu:\n      - title: \"$project_title\"\n        url: \"$page_path\"\n&/" _config.yml
                echo "Added Projects menu item with \"$project_title\" submenu."
                
                # Check if projects.html exists
                if [ ! -f "projects.html" ]; then
                    # Create projects.html
                    cat > "projects.html" << EOL
---
layout: default
title: "Projects"
---

<h1 class="page-title">Projects</h1>

<div class="project-list">
  <div class="project-card">
    <h2 class="project-title"><a href="/projects/${project_url}">${project_title}</a></h2>
    <div class="project-description">${project_description}</div>
    <a href="/projects/${project_url}" class="read-more">View Project</a>
  </div>
</div>
EOL
                    echo "Created projects.html page."
                else
                    # Update projects.html
                    sed -i '' "/<div class=\"project-list\">/a\\
  <div class=\"project-card\">\\
    <h2 class=\"project-title\"><a href=\"/projects/${project_url}\">${project_title}</a></h2>\\
    <div class=\"project-description\">${project_description}</div>\\
    <a href=\"/projects/${project_url}\" class=\"read-more\">View Project</a>\\
  </div>
" projects.html
                    echo "Updated projects.html page."
                fi
            else
                echo "Projects menu item not added."
            fi
        fi
    else
        # Create new navigation section
        echo
        echo "No navigation section found in _config.yml."
        echo "Would you like to create a new navigation section with a Projects menu item?"
        read -p "Enter 'y' to create, any other key to skip: " create_nav
        
        if [ "$create_nav" == "y" ]; then
            # Create new navigation section
            page_path="/projects/$project_url"
            cat >> _config.yml << EOL

# Navigation
navigation:
  - title: "Home"
    url: "/"
  - title: "Projects"
    url: "/projects.html"
    submenu:
      - title: "${project_title}"
        url: "${page_path}"
EOL
            echo "Created new navigation section with Projects menu item and \"$project_title\" submenu."
            
            # Create projects.html
            cat > "projects.html" << EOL
---
layout: default
title: "Projects"
---

<h1 class="page-title">Projects</h1>

<div class="project-list">
  <div class="project-card">
    <h2 class="project-title"><a href="/projects/${project_url}">${project_title}</a></h2>
    <div class="project-description">${project_description}</div>
    <a href="/projects/${project_url}" class="read-more">View Project</a>
  </div>
</div>
EOL
            echo "Created projects.html page."
        else
            echo "Navigation not updated."
        fi
    fi
fi

echo "Done!"
