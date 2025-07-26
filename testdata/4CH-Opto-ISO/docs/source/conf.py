# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

import os
import sys

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = '4CH-Opto-ISO'
copyright = '2024, KiCad Project Team'
author = 'KiCad Project Team'
release = '1.0.0'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = [
    'myst_parser',
    'sphinx.ext.autodoc',
    'sphinx.ext.viewcode',
    'sphinx.ext.napoleon',
    'sphinx.ext.intersphinx',
]

templates_path = ['_templates']
exclude_patterns = []

# Language settings
language = 'de'

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'sphinx_rtd_theme'
html_static_path = ['_static']
html_title = f'{project} Dokumentation'

# -- Options for LaTeX output ------------------------------------------------

latex_engine = 'pdflatex'
latex_elements = {
    'papersize': 'a4paper',
    'pointsize': '10pt',
    'fncychap': '\\usepackage[Bjornstrup]{fncychap}',
    'fontenc': '\\usepackage[T1]{fontenc}',
    'inputenc': '\\usepackage[utf8]{inputenc}',
    'babel': '\\usepackage[german]{babel}',
    'preamble': r'''
\usepackage{textcomp}
\DeclareUnicodeCharacter{03BC}{\ensuremath{\mu}}
\DeclareUnicodeCharacter{03A9}{\ensuremath{\Omega}}
\DeclareUnicodeCharacter{03B1}{\ensuremath{\alpha}}
\DeclareUnicodeCharacter{03B2}{\ensuremath{\beta}}
\DeclareUnicodeCharacter{03B3}{\ensuremath{\gamma}}
\DeclareUnicodeCharacter{03B4}{\ensuremath{\delta}}
\DeclareUnicodeCharacter{03B5}{\ensuremath{\varepsilon}}
\DeclareUnicodeCharacter{03B8}{\ensuremath{\theta}}
\DeclareUnicodeCharacter{03BB}{\ensuremath{\lambda}}
\DeclareUnicodeCharacter{03C0}{\ensuremath{\pi}}
\DeclareUnicodeCharacter{03C1}{\ensuremath{\rho}}
\DeclareUnicodeCharacter{03C3}{\ensuremath{\sigma}}
\DeclareUnicodeCharacter{03C4}{\ensuremath{\tau}}
\DeclareUnicodeCharacter{03C6}{\ensuremath{\varphi}}
\DeclareUnicodeCharacter{03C9}{\ensuremath{\omega}}
\DeclareUnicodeCharacter{00B0}{\ensuremath{{}^{\circ}}}
\DeclareUnicodeCharacter{00B5}{\ensuremath{\mu}}
\DeclareUnicodeCharacter{2126}{\ensuremath{\Omega}}
''',
}

latex_documents = [
    ('index', '4CH-Opto-ISO.tex', f'{project} PCB-Projekt',
     'KiCad Project Team', 'manual'),
]

# -- MyST Parser configuration -----------------------------------------------

myst_enable_extensions = [
    "colon_fence",
    "deflist",
    "html_image",
    "html_admonition",
    "replacements",
    "smartquotes",
    "tasklist",
]

# Source file suffixes
source_suffix = {
    '.rst': None,
    '.md': 'myst_parser',
}
