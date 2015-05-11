## Application to compile files as one

This app was meant to compile markdown partials as one document for our sales team using Deckset for Mac.

### Installation

```gem install kisko-suits```

### Usage

Create a config file for your presentation:

File name 'my-presentation.md.conf' would cause kisko-suits to create a markdown file my-presentation.md

my-presentation.md.conf content is file names (with possible **relative** path):

```introduction.md
company/basic_information.md
project-details.md
CVs/antti.md
CVs/vesa.md
contact_information.md```

These will then be merged as my-presentation.md when you run:

```kisko-suits my-presentation.md.conf```

Super simple.

If you want to update the output file when any of the partials in config are updated, just use the -w switch:

```kisko-suits -w my-presentation.md.conf```
