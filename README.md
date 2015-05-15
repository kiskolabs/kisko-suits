## Application to compile files as one

This app was meant to compile a single Markdown file by including multiple files to be used by our sales team using Deckset for Mac.

We create sales presentations and such using [Deckset](http://www.decksetapp.com/). There are a lot of information on those documents that we need to use again and again. Our only solution was to copy and paste those slides to the new presentation each time we started to create one.

With Kisko Suits we can create re-usable slides (for example company intro, CVs, contact information) and include those to a compiled presentation. Kisko Suits will update the master Markdown file everytime an included slide is changed/added/removed.

Read our blog post about Kisko Suits [here](http://www.kiskolabs.com/work/kisko-suits/).

### Installation

Everything you need is already installed on every Apple computer. Just run:

```gem install kisko-suits```

### Usage

Create a config file (.suits file) for your presentation:

File name 'my-presentation.md.suits' would cause kisko-suits to create a Markdown file my-presentation.md

my-presentation.md.suits contains normal Markdown content and included portions (using **relative** paths). For example:

```
# Presentation #1

include: introduction.md
include: company/basic_information.md

## Custom extra information

All Markdown formatting **works**.

include: project-details.md
include: CVs/antti.md
include: CVs/vesa.md
include: contact_information.md
```

The included portions will be merged to the document and the end result will be saved as my-presentation.md when you run:

```kisko-suits my-presentation.md.suits```

Super simple.

If you want to update the output file when any of the included portions in the config are updated, just use the -w switch:

```kisko-suits -w my-presentation.md.suits```

This makes it fast to work with the files and see the end result in Deckset.

### CI Build Status

![](https://magnum.travis-ci.com/kiskolabs/kisko-suits.svg?token=DwseF79747iq46syMYaD)
