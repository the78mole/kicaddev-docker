# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------

project = '4CH-Opto-ISO PCB Projekt'
author = 'the78mole'
copyright = '2025, the78mole'
release = '1.0'
version = '1.0'

# -- General configuration ---------------------------------------------------

extensions = [
    'sphinx.ext.autodoc',
    'sphinx.ext.viewcode',
    'sphinx.ext.napoleon',
    'sphinx.ext.githubpages',
    'myst_parser',        # Markdown & ReStructuredText
]

templates_path = ['_templates']
exclude_patterns = []

language = 'de'

# -- Options for HTML output ------------------------------------------------

html_theme = 'sphinx_rtd_theme'
html_static_path = ['_static']

# Custom CSS
html_css_files = [
    'custom.css',
]

html_theme_options = {
    'canonical_url': '',
    'analytics_id': '',
    'logo_only': False,
    'display_version': True,
    'prev_next_buttons_location': 'bottom',
    'style_external_links': False,
    'vcs_pageview_mode': '',
    'style_nav_header_background': '#2980b9',
    # Toc options
    'collapse_navigation': True,
    'sticky_navigation': True,
    'navigation_depth': 4,
    'includehidden': True,
    'titles_only': False
}

# Source file suffixes
source_suffix = {
    '.rst': None,
    '.md': 'myst_parser',
}
