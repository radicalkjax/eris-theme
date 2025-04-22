# Comprehensive GitHub Pages Installation Guide for Eris Theme

This detailed guide will walk you through the process of setting up a Jekyll site with the Eris theme on GitHub Pages, from the very beginning to a fully deployed site.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [GitHub Setup](#github-setup)
3. [Installation Methods](#installation-methods)
   - [Method 1: Using Remote Theme](#method-1-using-remote-theme-recommended-for-github-pages)
   - [Method 2: Forking the Theme Repository](#method-2-forking-the-theme-repository)
   - [Method 3: Using the Ruby Gem](#method-3-using-the-ruby-gem)
4. [Configuration](#configuration)
5. [Content Creation](#content-creation)
6. [Customization](#customization)
7. [Deployment](#deployment)
8. [Troubleshooting](#troubleshooting)
9. [Advanced Topics](#advanced-topics)

## Prerequisites

Before you begin, ensure you have the following:

### For Local Development (Optional but Recommended)

- **Ruby**: Version 2.5.0 or higher
  - Check with: `ruby -v`
  - Install on macOS: `brew install ruby`
  - Install on Ubuntu/Debian: `sudo apt-get install ruby-full`
  - Install on Windows: Download from [RubyInstaller](https://rubyinstaller.org/)

- **RubyGems**: Latest version
  - Check with: `gem -v`
  - Update with: `gem update --system`

- **Bundler**: Version 2.3.0 or higher
  - Check with: `bundler -v`
  - Install with: `gem install bundler`

- **Jekyll**: Version 4.2.0 or higher
  - Check with: `jekyll -v`
  - Install with: `gem install jekyll`

- **Git**: Latest version
  - Check with: `git --version`
  - Install on macOS: `brew install git`
  - Install on Ubuntu/Debian: `sudo apt-get install git`
  - Install on Windows: Download from [Git for Windows](https://gitforwindows.org/)

### For GitHub Pages Only

- **GitHub Account**: Create one at [github.com](https://github.com/)

## GitHub Setup

1. **Create a GitHub Repository**

   For a user or organization site:
   - Create a new repository named `username.github.io` (replace `username` with your GitHub username)
   
   For a project site:
   - Create a new repository with any name you prefer

2. **Enable GitHub Pages**

   - Go to your repository on GitHub
   - Click on "Settings"
   - Scroll down to the "GitHub Pages" section
   - Select the branch you want to use (usually `main` or `gh-pages`)
   - Click "Save"

## Installation Methods

Choose one of the following methods to install the Eris theme:

### Method 1: Using Remote Theme (Recommended for GitHub Pages)

This method uses the `jekyll-remote-theme` plugin to load the theme directly from GitHub.

1. **Create a new repository or use an existing one**

2. **Create the following files in your repository:**

   **_config.yml**:
   ```yaml
   # Site settings
   title: "Your Site Title"
   description: "Your site description"
   url: "https://username.github.io" # Replace with your GitHub Pages URL
   baseurl: "" # Leave empty for user/org sites, use "/repo-name" for project sites
   
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
     - title: Projects
       url: /projects.html
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

   **Gemfile**:
   ```ruby
   source "https://rubygems.org"
   
   gem "jekyll", "~> 4.2"
   gem "jekyll-remote-theme"
   gem "jekyll-feed"
   gem "jekyll-seo-tag"
   
   # Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data gem
   # and associated library.
   platforms :mingw, :x64_mingw, :mswin, :jruby do
     gem "tzinfo", "~> 1.2"
     gem "tzinfo-data"
   end
   
   # Performance-booster for watching directories on Windows
   gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]
   
   # Lock `http_parser.rb` gem to `v0.6.x` on JRuby builds since newer versions of the gem
   # do not have a Java counterpart.
   gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]
   ```

   **index.html**:
   ```html
   ---
   layout: default
   title: Home
   ---
   
   <div class="post-card">
     <h1 class="post-title">Welcome to My Site</h1>
     <div class="post-content">
       <p>This is my website using the Eris theme.</p>
     </div>
   </div>
   ```

3. **Commit and push these files to your repository**

   ```bash
   git add .
   git commit -m "Initial commit with Eris theme"
   git push origin main
   ```

4. **Wait for GitHub Pages to build your site**

   - Go to your repository on GitHub
   - Click on "Settings" > "Pages"
   - You should see a message saying "Your site is published at https://username.github.io"

### Method 2: Forking the Theme Repository

This method involves forking the theme repository and then customizing it.

1. **Fork the Eris theme repository**

   - Go to [github.com/radicalkjax/eris-theme](https://github.com/radicalkjax/eris-theme)
   - Click the "Fork" button in the top-right corner

2. **Rename the repository (for user/organization sites)**

   - Go to your fork's "Settings"
   - Rename the repository to `username.github.io`

3. **Update the configuration**

   - Edit the `_config.yml` file to update site settings, navigation, and social links

4. **Commit and push your changes**

   ```bash
   git add .
   git commit -m "Customize Eris theme"
   git push origin main
   ```

5. **Enable GitHub Pages**

   - Go to your repository's "Settings" > "Pages"
   - Select the branch you want to use (usually `main`)
   - Click "Save"

### Method 3: Using the Ruby Gem

This method is for local development and requires more technical knowledge.

1. **Create a new Jekyll site**

   ```bash
   jekyll new my-site
   cd my-site
   ```

2. **Add the Eris theme to your Gemfile**

   ```bash
   echo 'gem "eris-theme"' >> Gemfile
   ```

3. **Update your _config.yml**

   ```bash
   echo 'theme: eris-theme' >> _config.yml
   ```

4. **Install dependencies**

   ```bash
   bundle install
   ```

5. **Start the Jekyll server**

   ```bash
   bundle exec jekyll serve
   ```

6. **Deploy to GitHub Pages**

   - Create a new repository on GitHub
   - Push your local site to the repository
   - Enable GitHub Pages in the repository settings

## Configuration

The Eris theme is configured through the `_config.yml` file. Here's a detailed explanation of each section:

### Site Settings

```yaml
# Site settings
title: "Your Site Title"
description: "Your site description"
url: "https://username.github.io"
baseurl: ""
```

- `title`: The title of your site, displayed in the browser tab and header
- `description`: A brief description of your site, used for SEO
- `url`: The full URL to your site
- `baseurl`: The subpath of your site, empty for user/organization sites, `/repo-name` for project sites

### Build Settings

```yaml
# Build settings
markdown: kramdown
remote_theme: radicalkjax/eris-theme
```

- `markdown`: The Markdown processor to use
- `remote_theme`: The GitHub repository to use as a theme (for GitHub Pages)

### Plugins

```yaml
# Plugins
plugins:
  - jekyll-remote-theme
  - jekyll-feed
  - jekyll-seo-tag
```

- `jekyll-remote-theme`: Required for using a remote theme on GitHub Pages
- `jekyll-feed`: Generates an Atom feed of your posts
- `jekyll-seo-tag`: Adds metadata tags for search engines

### Navigation

```yaml
# Navigation
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
```

- `title`: The text to display in the navigation menu
- `url`: The URL to link to
- `submenu`: An optional list of submenu items

### Theme Colors

```yaml
# Theme color settings
theme_color:
  primary: "#6d105a"  # Primary theme color
  text: "#ffffff"     # Text color
```

- `primary`: The primary color of the theme
- `text`: The text color of the theme

### Social Links

```yaml
# Social media links
social:
  bluesky: "https://bsky.app/profile/yourusername"
  linkedin: "https://www.linkedin.com/in/yourusername"
  instagram: "https://www.instagram.com/yourusername"
  github: "https://github.com/yourusername"
```

- Add or remove social media links as needed
- Each link will be displayed in the site header

## Content Creation

The Eris theme includes several scripts to help you create content:

### Creating Pages

Use the `create-page.sh` script to create a new page:

```bash
./eris-theme/create-page.sh
```

Or create a page manually:

```markdown
---
layout: default
title: "Page Title"
---

<div class="post-card">
  <h1 class="post-title">Page Title</h1>
  <div class="post-content">
    <p>Your content here...</p>
  </div>
</div>
```

### Creating Blog Posts

Use the `create-post.sh` script to create a new blog post:

```bash
./eris-theme/create-post.sh
```

Or create a post manually in the `_posts` directory:

```markdown
---
layout: post
title: "Post Title"
date: 2025-04-22 12:00:00 -0700
categories: jekyll theme
tags: [jekyll, theme, eris]
---

Your post content here...
```

### Creating Special Pages

The theme includes scripts for creating specific types of pages:

- `create-home.sh`: Creates a customized home page
- `create-about.sh`: Creates an about page with biography and timeline
- `create-contact.sh`: Creates a contact page with a contact form
- `create-blog-index.sh`: Creates a blog index page to list all posts
- `create-project.sh`: Creates a new project page with proper front matter

## Customization

### Theme Colors

Edit the `theme_color` section in `_config.yml`:

```yaml
theme_color:
  primary: "#6d105a"  # Change to your preferred color
  text: "#ffffff"     # Change to your preferred text color
```

### Custom CSS

Create a `main.scss` file in the `assets/css` directory:

```scss
---
---

// Import variables and set theme colors from config
$primary-color: {{ site.theme_color.primary | default: "#6d105a" }};
$text-color: {{ site.theme_color.text | default: "#ffffff" }};

// Import Eris theme
@import "eris";

// Add your custom styles below
.custom-class {
  color: red;
}
```

### Overriding Theme Files

To override any theme file, create a file with the same path in your site:

```
your-site/
├── _includes/
│   └── header.html  # Overrides eris-theme/_includes/header.html
├── _layouts/
│   └── post.html    # Overrides eris-theme/_layouts/post.html
└── assets/
    └── css/
        └── main.scss # Extends theme CSS
```

## Deployment

### Automatic Deployment with GitHub Pages

If you're using GitHub Pages, your site will be automatically deployed when you push changes to your repository.

### Manual Deployment

Use the `deploy-to-github.sh` script to deploy your site to GitHub Pages:

```bash
./eris-theme/deploy-to-github.sh
```

## Troubleshooting

### Common Issues

#### Jekyll Build Errors

If you encounter errors when building your site:

1. Check your `_config.yml` for syntax errors
2. Ensure all required plugins are installed
3. Check your Markdown files for syntax errors

#### CSS Not Loading

If your CSS is not loading:

1. Check your `baseurl` setting in `_config.yml`
2. Ensure your CSS files are in the correct location
3. Check for syntax errors in your SCSS files

#### JavaScript Errors

If you encounter JavaScript errors:

1. Check your browser console for error messages
2. Ensure your JavaScript files are in the correct location
3. Check for syntax errors in your JavaScript files

### Getting Help

If you encounter issues not covered in this guide:

1. Check the [Jekyll documentation](https://jekyllrb.com/docs/)
2. Search for your issue on [Stack Overflow](https://stackoverflow.com/questions/tagged/jekyll)
3. Open an issue on the [Eris theme repository](https://github.com/radicalkjax/eris-theme/issues)

## Advanced Topics

### Custom Domains

To use a custom domain with GitHub Pages:

1. Go to your repository's "Settings" > "Pages"
2. Under "Custom domain", enter your domain name
3. Click "Save"
4. Create a `CNAME` file in your repository with your domain name

### SSL/HTTPS

GitHub Pages automatically enables HTTPS for all sites. To enforce HTTPS:

1. Go to your repository's "Settings" > "Pages"
2. Check "Enforce HTTPS"

### Jekyll Plugins

GitHub Pages supports a [limited set of plugins](https://pages.github.com/versions/). To use other plugins:

1. Add the plugin to your `Gemfile` and `_config.yml`
2. Build your site locally with `bundle exec jekyll build`
3. Push the generated `_site` directory to GitHub

### Continuous Integration

For more advanced workflows, consider using GitHub Actions:

1. Create a `.github/workflows/jekyll.yml` file in your repository
2. Add a workflow configuration to build and deploy your site
3. Push the changes to GitHub

Example workflow:

```yaml
name: Jekyll site CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Build the site in the jekyll/builder container
      run: |
        docker run \
        -v ${{ github.workspace }}:/srv/jekyll -v ${{ github.workspace }}/_site:/srv/jekyll/_site \
        jekyll/builder:latest /bin/bash -c "chmod -R 777 /srv/jekyll && jekyll build --future"
    - name: Deploy
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./_site
```

---

This guide should help you get started with the Eris theme on GitHub Pages. If you have any questions or need further assistance, please open an issue on the [Eris theme repository](https://github.com/radicalkjax/eris-theme/issues).
