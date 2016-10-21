# Glow responsive Theme for OXID eShop

based on Flow Theme: https://github.com/OXID-eSales/flow_theme

## Work in Progress! to do:
* testing replaced scripts
* cleanup less and rework replaced/removed 3rd-party libraries

### Installation
    cd application/views/
    git clone git@github.com:vanilla-thunder/glow.git
    ln -s ../application/views/glow/out/glow ../../out/glow

### development
    cd out/glow
    npm install
    npm start

### Important changes
* Logo path is now relative to ``out/pictures/wysiwygpro/``
* background image path changed to ``out/pictures/wysiwygpro/``
* minor layout changes
* replaced old reused Azure JavaScripts with simple jQuery
* removed jQuery-UI


### Features
* nodejs less compier & js minifier included
* using bower for 3rd party libraries

### Bugfixes
* [6434 - Strange sidebar layout on list.tpl](https://bugs.oxid-esales.com/view.php?id=6434)
* [6441 - resource not found: js/libs/cookie/jquery.cookie.min.js](https://bugs.oxid-esales.com/view.php?id=6441)
* [6442 - Sticky Navigation in Full-Width Layout](https://bugs.oxid-esales.com/view.php?id=6442)
* [6509 - articles with one or more pick lists are put into basket every time one chooses a setting](https://bugs.oxid-esales.com/view.php?id=6509)


### Replaced discontinued 3rd-party Libraries:
* jQuery-Bootstrap-Validation -> [Bootstrap Validator](http://1000hz.github.io/bootstrap-validator/)
* Photoswipe -> [Lightgallery](http://sachinchoolur.github.io/lightGallery/)
* jQuery-cookie -> [js-Cookie](https://github.com/js-cookie/js-cookie)

### Removed 3rd-party Libraries:
* jQuery-UI
* Bootstrap-Select
