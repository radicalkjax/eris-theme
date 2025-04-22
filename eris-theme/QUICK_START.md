# Eris Theme Quick Start Guide

This guide will help you quickly set up a new Jekyll site with the Eris theme, even if you're new to Jekyll or GitHub Pages.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- **Ruby**: Version 2.5.0 or higher
  - Check with: `ruby -v`
  - Install on macOS: `brew install ruby`
  - Install on Ubuntu/Debian: `sudo apt-get install ruby-full`
  - Install on Windows: Download from [RubyInstaller](https://rubyinstaller.org/)

- **RubyGems**: Latest version
  - Check with: `gem -v`
  - Update with: `gem update --system`

- **Jekyll**: Version 4.2.0 or higher
  - Check with: `jekyll -v`
  - Install with: `gem install jekyll bundler`

## Installation Options

Choose the option that best fits your needs:

### Option 1: Using Helper Scripts (Recommended for Beginners)

The Eris theme includes several helper scripts to make installation and setup easy:

1. **For a brand new site**:
   ```bash
   # Make the script executable
   chmod +x eris-theme/create-site.sh
   
   # Run the script
   ./eris-theme/create-site.sh
   ```
   This script will:
   - Create a new Jekyll site
   - Install the Eris theme
   - Set up basic configuration
   - Create sample pages

2. **For testing the theme**:
   ```bash
   # Make the script executable
   chmod +x eris-theme/test-theme.sh
   
   # Run the script
   ./eris-theme/test-theme.sh
   ```
   This script will create a temporary test site to verify the theme is working correctly.

3. **For an existing site**:
   ```bash
   # Make the script executable
   chmod +x eris-theme/install.sh
   
   # Run the script
   ./eris-theme/install.sh
   ```
   This script will guide you through adding the Eris theme to an existing Jekyll site.

### Option 2: Manual Installation (For Existing Sites)

If you prefer to manually install the theme:

1. **Add the theme to your site's `Gemfile`**:
   ```ruby
   # Add this line to your Gemfile
   gem "eris-theme"
   ```

2. **Update your site's `_config.yml`**:
   ```yaml
   # Add this line to your _config.yml
   theme: eris-theme
   
   # Add these sections for theme configuration
   navigation:
     - title: Blog
       url: /blog.html
     - title: About
       url: /about.html
   
   theme_color:
     primary: "#6d105a"
     text: "#ffffff"
   ```

3. **Install dependencies**:
   ```bash
   # Install all required gems
   bundle install
   ```

4. **Start your Jekyll server**:
   ```bash
   # Start the development server
   bundle exec jekyll serve
   ```
   Your site will be available at http://localhost:4000

### Option 3: GitHub Pages Installation

For GitHub Pages deployment:

1. **Create a new repository** on GitHub (or use an existing one)

2. **Add the remote theme plugin** to your site's `Gemfile`:
   ```ruby
   source "https://rubygems.org"
   
   gem "jekyll", "~> 4.2"
   gem "jekyll-remote-theme"
   gem "jekyll-feed"
   gem "jekyll-seo-tag"
   ```

3. **Update your site's `_config.yml`**:
   ```yaml
   # Site settings
   title: "Your Site Title"
   description: "Your site description"
   
   # Build settings
   markdown: kramdown
   remote_theme: radicalkjax/eris-theme
   
   # Plugins
   plugins:
     - jekyll-remote-theme
     - jekyll-feed
     - jekyll-seo-tag
   
   # Navigation
   navigation:
     - title: Blog
       url: /blog.html
     - title: About
       url: /about.html
   
   # Theme color settings
   theme_color:
     primary: "#6d105a"
     text: "#ffffff"
   ```

4. **Push to GitHub** and enable GitHub Pages in your repository settings

For a comprehensive GitHub Pages guide, see [GITHUB_PAGES_GUIDE.md](GITHUB_PAGES_GUIDE.md).

## Creating Content

The Eris theme includes scripts to help you create various types of content:

### Blog Posts

```bash
# Make the script executable
chmod +x eris-theme/create-post.sh

# Run the script
./eris-theme/create-post.sh
```

### Pages

```bash
# Make the script executable
chmod +x eris-theme/create-page.sh

# Run the script
./eris-theme/create-page.sh
```

### Special Pages

- **Home Page**: `./eris-theme/create-home.sh`
- **About Page**: `./eris-theme/create-about.sh`
- **Contact Page**: `./eris-theme/create-contact.sh`
- **Blog Index**: `./eris-theme/create-blog-index.sh`
- **Project Page**: `./eris-theme/create-project.sh`

## Theme Configuration

Edit your site's `_config.yml` file to customize the theme:

```yaml
# Site settings
title: "Your Site Title"
description: "Your site description"
url: "https://yourdomain.com"
baseurl: ""  # Leave empty for user/org sites, use "/repo-name" for project sites

# Navigation (hierarchical structure)
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
  primary: "#6d105a"  # Primary theme color
  text: "#ffffff"     # Text color

# Social media links
social:
  bluesky: "https://bsky.app/profile/yourusername"
  linkedin: "https://www.linkedin.com/in/yourusername"
  instagram: "https://www.instagram.com/yourusername"
  github: "https://github.com/yourusername"
```

## Customization

To customize the theme's appearance:

```bash
# Make the script executable
chmod +x eris-theme/customize-theme.sh

# Run the script
./eris-theme/customize-theme.sh
```

This interactive script will help you customize:
- Theme colors
- Navigation
- Social links
- CSS styles

## Deployment

To deploy your site to GitHub Pages:

```bash
# Make the script executable
chmod +x eris-theme/deploy-to-github.sh

# Run the script
./eris-theme/deploy-to-github.sh
```

## Next Steps

After setting up your site:

1. **Create content** using the helper scripts
2. **Customize the theme** to match your style
3. **Preview your site** with `bundle exec jekyll serve`
4. **Deploy your site** to GitHub Pages or your preferred hosting

## Getting Help

For more detailed information:
- [README.md](README.md): Overview of the theme
- [INSTALL.md](INSTALL.md): Detailed technical installation guide
- [GITHUB_PAGES_GUIDE.md](GITHUB_PAGES_GUIDE.md): Comprehensive GitHub Pages guide
