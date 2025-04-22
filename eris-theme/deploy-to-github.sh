#!/bin/bash

# Eris Theme - Deploy to GitHub Pages Script
# This script helps users deploy their Jekyll site to GitHub Pages

echo "Eris Theme - Deploy to GitHub Pages"
echo "=================================="
echo

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Please install Git first."
    exit 1
fi

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

# Check if it's a Git repository
if [ ! -d ".git" ]; then
    echo "This directory is not a Git repository."
    read -p "Would you like to initialize a Git repository? (y/n): " init_git
    
    if [ "$init_git" == "y" ]; then
        git init
        echo "Git repository initialized."
    else
        echo "Cannot deploy to GitHub Pages without a Git repository."
        exit 1
    fi
fi

# Check if GitHub repository is configured
remote_url=$(git config --get remote.origin.url)
if [ -z "$remote_url" ]; then
    echo "No GitHub remote repository is configured."
    read -p "Enter your GitHub repository URL (e.g., https://github.com/username/repo.git): " github_url
    
    if [ -z "$github_url" ]; then
        echo "Error: GitHub repository URL is required."
        exit 1
    fi
    
    git remote add origin "$github_url"
    echo "GitHub remote repository configured."
else
    echo "GitHub remote repository: $remote_url"
fi

# Ask which branch to deploy to
echo
echo "Which branch would you like to deploy to?"
echo "1) gh-pages (Project site)"
echo "2) main (User or organization site)"
read -p "Enter your choice (1 or 2): " branch_choice

if [ "$branch_choice" == "1" ]; then
    deploy_branch="gh-pages"
elif [ "$branch_choice" == "2" ]; then
    deploy_branch="main"
else
    echo "Invalid choice. Using gh-pages branch."
    deploy_branch="gh-pages"
fi

# Build the site
echo
echo "Building the Jekyll site..."
bundle exec jekyll build

# Check if build was successful
if [ $? -ne 0 ]; then
    echo "Error: Jekyll build failed."
    exit 1
fi

echo "Jekyll site built successfully."

# Deploy to GitHub Pages
echo
echo "Deploying to GitHub Pages..."

# Check if we're deploying to gh-pages branch
if [ "$deploy_branch" == "gh-pages" ]; then
    # Check if gh-pages branch exists
    if git show-ref --verify --quiet refs/heads/gh-pages; then
        echo "gh-pages branch already exists."
    else
        echo "Creating gh-pages branch..."
        git checkout --orphan gh-pages
        git reset --hard
        git commit --allow-empty -m "Initial gh-pages commit"
        git checkout -
        echo "gh-pages branch created."
    fi
    
    # Copy _site contents to a temporary directory
    temp_dir=$(mktemp -d)
    cp -R _site/* "$temp_dir"/
    
    # Switch to gh-pages branch
    git checkout gh-pages
    
    # Remove existing files
    git rm -rf .
    
    # Copy _site contents
    cp -R "$temp_dir"/* .
    
    # Add .nojekyll file to bypass Jekyll processing on GitHub
    touch .nojekyll
    
    # Add and commit changes
    git add .
    git commit -m "Deploy to GitHub Pages: $(date)"
    
    # Push to GitHub
    git push origin gh-pages
    
    # Switch back to original branch
    git checkout -
    
    # Clean up
    rm -rf "$temp_dir"
else
    # Deploying to main branch
    # Add all files
    git add .
    
    # Commit changes
    git commit -m "Update site: $(date)"
    
    # Push to GitHub
    git push origin main
fi

echo
echo "Deployment complete!"
echo "Your site should be available at: $(git config --get remote.origin.url | sed 's/\.git$//' | sed 's/https:\/\/github.com\//https:\/\//').github.io/"
echo
echo "Note: It may take a few minutes for the changes to appear on GitHub Pages."
