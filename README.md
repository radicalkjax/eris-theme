# Eris Jekyll Theme

Eris is a modern, minimalist Jekyll theme with a distinctive purple color scheme and unique border styling. It features a responsive design, dropdown navigation, social media integration, and built-in support for Mermaid diagrams.

<!-- Note: Replace this comment with an actual screenshot before distribution -->
<!-- ![Eris Theme Preview](screenshot.png) -->

## Documentation

| Document | Description |
|----------|-------------|
| [README.md](README.md) | Main theme overview and technical details |
| [THEME_PACKAGE.md](eris-theme/THEME_PACKAGE.md) | Guide to the exported theme package |
| [QUICK_START.md](eris-theme/QUICK_START.md) | Quick start guide for beginners |
| [INSTALL.md](INSTALL.md) | Detailed technical installation guide |
| [GITHUB_PAGES_GUIDE.md](eris-theme/GITHUB_PAGES_GUIDE.md) | Comprehensive GitHub Pages guide |
| [README-EXPORT.md](README-EXPORT.md) | Information about the theme export |

## Helper Scripts

| Script | Description |
|--------|-------------|
| [install.sh](eris-theme/install.sh) | Helps users install the theme in their Jekyll site |
| [create-site.sh](eris-theme/create-site.sh) | Creates a new Jekyll site with the Eris theme |
| [test-theme.sh](eris-theme/test-theme.sh) | Creates a test site to verify the theme is working correctly |
| [customize-theme.sh](eris-theme/customize-theme.sh) | Interactive script to customize theme colors, navigation, and more |
| [update-theme.sh](eris-theme/update-theme.sh) | Updates the theme in an existing Jekyll site |
| [create-home.sh](eris-theme/create-home.sh) | Creates a customized home page |
| [create-about.sh](eris-theme/create-about.sh) | Creates an about page with biography and timeline |
| [create-post.sh](eris-theme/create-post.sh) | Creates a new blog post with proper front matter |
| [create-page.sh](eris-theme/create-page.sh) | Creates a new page with proper front matter |
| [create-project.sh](eris-theme/create-project.sh) | Creates a new project page with proper front matter |
| [create-contact.sh](eris-theme/create-contact.sh) | Creates a contact page with a contact form |
| [create-blog-index.sh](eris-theme/create-blog-index.sh) | Creates a blog index page to list all posts |
| [deploy-to-github.sh](eris-theme/deploy-to-github.sh) | Deploys the Jekyll site to GitHub Pages |

## Technical Overview

Eris is built with a modular architecture that separates concerns and makes customization straightforward. The theme leverages Sass for styling, vanilla JavaScript for interactivity, and Jekyll's templating system for content management.

```mermaid
graph TD
    A[Jekyll Site] --> B[Eris Theme]
    B --> C[Layouts]
    B --> D[Includes]
    B --> E[Sass Styling]
    B --> F[JavaScript]
    
    C --> C1[default.html]
    C --> C2[post.html]
    
    D --> D1[header.html]
    D --> D2[footer.html]
    
    E --> E1[_variables.scss]
    E --> E2[_base.scss]
    E --> E3[_layout.scss]
    E --> E4[_components.scss]
    E --> E5[_responsive.scss]
    
    F --> F1[main.js]
    F --> F2[social-links.js]
```

### Directory Structure

```
eris-theme/
├── _includes/              # Reusable components
│   ├── footer.html         # Site footer
│   └── header.html         # Site header with navigation
├── _layouts/               # Page templates
│   ├── default.html        # Base layout
│   └── post.html           # Blog post layout
├── _sass/                  # Sass partials
│   ├── _base.scss          # Base styles
│   ├── _components.scss    # UI components
│   ├── _layout.scss        # Layout components
│   ├── _responsive.scss    # Responsive design
│   ├── _variables.scss     # Theme variables
│   └── eris.scss           # Main Sass file
├── assets/
│   ├── css/
│   │   ├── fonts.css       # Font definitions
│   │   └── main.scss       # Main stylesheet
│   ├── fonts/              # Web fonts
│   └── js/
│       ├── main.js         # Main JavaScript
│       └── social-links.js # Social media integration
├── _config.yml             # Theme configuration
├── .gitignore              # Git ignore file
├── Gemfile                 # Gem dependencies
├── INSTALL.md              # Installation guide
├── LICENSE.txt             # MIT license
├── package.json            # npm package configuration
├── README.md               # This file
└── setup.sh                # Setup script
```

## Technical Features

### 1. Responsive Design Architecture

The theme uses a mobile-first approach with carefully crafted breakpoints:

```mermaid
graph LR
    A[Responsive Design] --> B[Mobile First]
    A --> C[CSS Grid & Flexbox]
    A --> D[Media Queries]
    
    D --> E[Extra Small: &lt;500px]
    D --> F[Small: 500-768px]
    D --> G[Medium: 768-900px]
    D --> H[Large: 900-1024px]
    D --> I[Extra Large: &gt;1024px]
```

### 2. Theme Customization System

Eris uses a robust variable system that makes customization straightforward:

```mermaid
graph TD
    A[Theme Customization] --> B[_config.yml Settings]
    A --> C[Sass Variables]
    A --> D[File Overrides]
    
    B --> B1[Theme Colors]
    B --> B2[Navigation Structure]
    B --> B3[Social Links]
    
    C --> C1[Color Variables]
    C --> C2[Typography Variables]
    C --> C3[Layout Variables]
    
    D --> D1[Override Layouts]
    D --> D2[Override Includes]
    D --> D3[Override Styles]
```

### 3. JavaScript Architecture

The theme's JavaScript is organized for maintainability and performance:

```mermaid
graph TD
    A[JavaScript] --> B[Event-Driven Architecture]
    A --> C[Module Pattern]
    A --> D[Progressive Enhancement]
    
    B --> B1[DOMContentLoaded Events]
    B --> B2[User Interaction Events]
    
    C --> C1[main.js]
    C --> C2[social-links.js]
    
    D --> D1[Core Functionality Without JS]
    D --> D2[Enhanced With JS]
```

### 4. Mermaid Diagram Integration

The theme includes built-in support for Mermaid diagrams:

```mermaid
sequenceDiagram
    participant User
    participant Jekyll
    participant Mermaid
    
    User->>Jekyll: Write Markdown with Mermaid code
    Jekyll->>User: Generate HTML page
    User->>Mermaid: Load Mermaid library
    Mermaid->>User: Parse and render diagrams
```

## Performance Optimizations

- Minimal CSS with modular architecture
- Vanilla JavaScript with no dependencies
- Optimized font loading strategy
- Responsive images with appropriate sizing
- Lazy-loaded components

## Browser Compatibility

- Chrome (latest 2 versions)
- Firefox (latest 2 versions)
- Safari (latest 2 versions)
- Edge (latest 2 versions)
- Opera (latest 2 versions)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/radicalkjax/eris-theme.

## License

The theme is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
