## Application to compile files as one

This app was meant to compile markdown partials as one document for our sales team using Deckset for Mac.

We create sales presentations and such using [Deckset](http://www.decksetapp.com/). There are a lot of information on those documents that we need to use again and again. Our only solution was to copy and paste that information to the new presentation each time we started to create one.

With Kisko Suits we can create re-usable partials (for example company intro, CVs, contact information) and compile a presentation. Kisko Suits will update the master markdown file everytime a partial is changed/added/removed.

### Installation

```gem install kisko-suits```

### Usage

Create a config file for your presentation:

File name 'my-presentation.md.conf' would cause kisko-suits to create a markdown file my-presentation.md

my-presentation.md.conf content is file names (with possible **relative** path):

```
introduction.md
company/basic_information.md
project-details.md
CVs/antti.md
CVs/vesa.md
contact_information.md
```

These will then be merged as my-presentation.md when you run:

```kisko-suits my-presentation.md.conf```

Super simple.

If you want to update the output file when any of the partials in config are updated, just use the -w switch:

```kisko-suits -w my-presentation.md.conf```
