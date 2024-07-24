## Application to compile files as one

This app was meant to compile a single Markdown file by including multiple files to be used by our sales team using Deckset for Mac.

We create sales presentations and such using [Deckset](http://www.decksetapp.com/). There are a lot of information on those documents that we need to use again and again. Our only solution was to copy and paste those slides to the new presentation each time we started to create one.

With Kisko Suits we can create re-usable slides (for example company intro, CVs, contact information) and include those to a compiled presentation. Kisko Suits will update the master Markdown file everytime an included slide is changed/added/removed.

Read our blog post about Kisko Suits [here](http://www.kiskolabs.com/work/kisko-suits/).

### Installation

Everything you need is already installed on every Apple computer. Just run:

`gem install kisko-suits`

### Usage

Create a config file (.suits file) for your presentation:

File name 'my-presentation.md.suits' would cause kisko-suits to create a Markdown file my-presentation.md

my-presentation.md.suits contains normal Markdown content and included portions (using **relative** paths). For example:

```
# Presentation #1

$$custom_variables = amazing custom variables
include: introduction.md
include: company/basic_information.md

## Custom extra information

All Markdown formatting **works** and you can use $$custom_variables to save time.

include: project-details.md
include: CVs/antti.md
include: CVs/vesa.md
include: contact_information.md
```

The included portions will be merged to the document and the end result will be saved as my-presentation.md when you run:

```sh
kisko-suits my-presentation.md.suits
```

Super simple.

If you want to update the output file when any of the included portions in the config are updated, just use the -w switch:

```sh
kisko-suits -w my-presentation.md.suits
```

This makes it fast to work with the files and see the end result in Deckset.

### ZSH function

Add this to your `.zshrc` to use `deck my_presentation.md` and automatically create the `.suits` file, open it in atom and Deckset.

```zsh
function deck {
  local suits_file
  suits_file=($(echo $1 | xargs).suits)
  if [[ ! -e $1 ]] ; then
    touch $1
  fi
  if [[ ! -e $suits_file ]] ; then
    touch $suits_file
  fi
  open -a Deckset $1 && atom $suits_file && kisko-suits -w $suits_file
}
```

### CI Build Status

![](https://travis-ci.org/kiskolabs/kisko-suits.svg?branch=master)

## Development

### Running tests

```sh
bin/rspec spec
```

### Releasing new version

Bump the version with **meaningful** version change:

```sh
# pick one
gem bump --version patch # bumps to the next patch version
gem bump --version minor # bumps to the next minor version
gem bump --version major # bumps to the next major version
gem bump --version 1.1.1 # bumps to the specified version
```

Build & push the new version to Rubygems:

```sh
bin/rake release
```
