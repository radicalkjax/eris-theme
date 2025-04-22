# Eris Theme Export

This directory contains the exported version of the Eris Jekyll theme, ready for distribution and use in other Jekyll sites.

## Directory Structure

- `eris-theme/`: The exported theme directory, containing all necessary files for the theme
  - `_includes/`: HTML includes (header, footer, etc.)
  - `_layouts/`: HTML layouts (default, post, etc.)
  - `_sass/`: SCSS partials for styling
  - `assets/`: CSS, JavaScript, fonts, and images
  - `_posts/`: Sample blog posts
  - `projects/`: Sample project pages
  - Configuration files (gemspec, README, etc.)

## Using the Theme

The theme can be used in several ways:

1. **As a Ruby Gem**: Install the theme as a Ruby gem by running the `package.sh` script in the `eris-theme` directory.
2. **As a Remote Theme**: Use the theme directly from GitHub by adding it to your Jekyll site's configuration.
3. **By Copying Files**: Copy the theme files directly into your Jekyll site.

For detailed installation and usage instructions, see the following files:

- `eris-theme/QUICK_START.md`: Quick start guide for using the theme
- `eris-theme/README.md`: Comprehensive documentation for the theme
- `eris-theme/INSTALL.md`: Detailed technical installation guide
- `eris-theme/GITHUB_PAGES_GUIDE.md`: Comprehensive guide for GitHub Pages users

## Scripts

The following scripts are included to help with theme installation, customization, and content creation:

### Installation and Setup
- `eris-theme/install.sh`: Helps users install the theme in their Jekyll site
- `eris-theme/package.sh`: Packages the theme as a Ruby gem
- `eris-theme/setup.sh`: Sets up a new Jekyll site with the Eris theme
- `eris-theme/create-site.sh`: Creates a new Jekyll site with the Eris theme
- `eris-theme/test-theme.sh`: Creates a test site to verify the theme is working correctly

### Theme Customization
- `eris-theme/customize-theme.sh`: Interactive script to customize theme colors, navigation, and more
- `eris-theme/update-theme.sh`: Updates the theme in an existing Jekyll site

### Content Creation
- `eris-theme/create-home.sh`: Creates a customized home page
- `eris-theme/create-about.sh`: Creates an about page with biography and timeline
- `eris-theme/create-post.sh`: Creates a new blog post with proper front matter
- `eris-theme/create-page.sh`: Creates a new page with proper front matter
- `eris-theme/create-project.sh`: Creates a new project page with proper front matter
- `eris-theme/create-contact.sh`: Creates a contact page with a contact form
- `eris-theme/create-blog-index.sh`: Creates a blog index page to list all posts

### Deployment
- `eris-theme/deploy-to-github.sh`: Deploys the Jekyll site to GitHub Pages

## License

The theme is available as open source under the terms of the MIT License.
