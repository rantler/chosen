# Chosen

Chosen is a library for making long, unwieldy select boxes more user friendly.

- jQuery support: 1.4+
- Prototype support: 1.7+

For documentation, usage, and examples, see:  
http://harvesthq.github.com/chosen

### Contributing to Chosen

Contributions and pull requests are very welcome. Please follow these guidelines when submitting new code.

1. Make all changes in Coffeescript files, **not** JavaScript files.
2. For feature changes, update both jQuery *and* Prototype versions
3. Use 'cake build' to generate Chosen's JavaScript file and minified version.
4. Don't touch the VERSION file
5. Submit a Pull Request using GitHub.

### Using CoffeeScript & Cake

First, make sure you have the proper CoffeeScript / Cake set-up in place.

1. Install Coffeescript: the [CoffeeScript documentation](http://jashkenas.github.com/coffee-script/) provides easy-to-follow instructions.
2. Install UglifyJS: <code>npm -g install uglify-js</code>
3. Verify that your $NODE_PATH is properly configured using <code>echo $NODE_PATH</code>

Once you're configured, building the JavasScript from the command line is easy:

    cake build                # build Chosen from source
    cake watch                # watch coffee/ for changes and build Chosen
    
If you're interested, you can find the recipes in Cakefile.


### Chosen Credits

- Built by [Harvest](http://www.getharvest.com/)
- Concept and development by [Patrick Filler](http://www.patrickfiller.com/)
- Design and CSS by [Matthew Lettini](http://matthewlettini.com/)

### Notable Forks

- [Chosen for MooTools](https://github.com/julesjanssen/chosen), by Jules Janssen
- [Chosen Drupal 7 Module](https://github.com/Polzme/chosen), by Pol Dell'Aiera

### This Fork

Adds ability to start out with an empty SELECT element that is populated by user choices that are auto-completed using AJAX requests.

For example, if one starts out with a SELECT element like the one below:

    <select data-placeholder="Choose a Country..." class="chzn-select chzn-dynamic" data-dynamic-search="true" style="width: 350px;"
        data-search-url="/search/location_tokens?type=country" tabindex="2" name="single_select_chosen_country" />

Then as the user types characters, AJAX requests are made to the URI "/search/location_tokens?type=country&q=al" where "al" is whatever the user has typed so far.

The response expected from this AJAX request is a JSON collection that resembles this:

    [{"name": "Australia", "id": 123}, {"name": "Italy", "id": 234}, {"name": "Malaysia", "id": 345}, {"name": "New Zealand", "id": 456}, {"name": "Portugal", "id": 567}]

These hashes are used to dynamically create items that are then presented to the user to choose from. When the user makes a selection that item is dynamically added to the SELECT element as an OPTION element with the SELECTED attribute set, the VALUE attribute set to the ID of the item and the HTML content of the OPTION element set to the NAME of the item.

That is essentially how it works. It is a quick-n-dirty solution and could have been implemented more elegantly, but I was time boxed to only a couple of days to get it working and I had never used CoffeeScript before.

Good luck!