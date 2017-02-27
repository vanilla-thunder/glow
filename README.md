# Glow responsive Theme für OXID eShop
**demo: [http://glow.mb-dev.de](http://glow.mb-dev.de)**  
basierend auf Flow Theme: https://github.com/OXID-eSales/flow_theme

### Aktuelle To-Do Liste
* Formular Validierung für E-Mail Adressen, PLZ, etc
* paypal+ testen

### Voraussetzungen
* [vt-themesettings](https://github.com/vanilla-thunder/vt-themesettings) für Theme Einstellungen

### Installation
    cd application/views/
    git clone git@github.com:vanilla-thunder/glow.git
    ln -s ../application/views/glow/out/glow ../../out/glow
oder:
 1. Archiv herunterladen
 2. nach application/views/glow entpacken
 3. application/views/glow/out/glow nach out/glow kopieren

### Theme Einstellungen
- Größe des Kategoriebildes: 1300*400

### LESS + CSS + JS bearbeiten
in out/glow liegt eine Nodejs App, die das Kompilieren von LESS und Zusammenfassen von JS Dateien übernimmt.
Diese wird so gestartet (Nodejs erforderlich):
```Shell
cd out/glow
npm install
npm start
``` 
#### Less:
Die Hauptdatei liegt unter: out/glow/src/less/glow.less
Diese wird zu:  out/glow/src/css/glow.min.css

#### JS

### New Features 
* live price update for amount prices
* tprice will be inherited from parent article
* show/hide sidebar by changing theme settings
* smaller header navigation on mobile devices
* additional smaller listitem template for crossselling and accessories


### Important changes
* Logo path is now relative to ``out/pictures/wysiwygpro/``
* background image path changed to ``out/pictures/wysiwygpro/``
* different layout for product details page
* some layout changes in checkout 
* replaced old reused Azure JavaScripts with simple jQuery
* removed jQuery-UI and some other libs (see list below)
* *tpl/widget/product/selectbox.tpl* moved to *tpl/page/details/inc/selectbox.tpl*  
   **because selectbox.tpl is not a widget!**
* selection dropdowns replaced with native select elements

### Features
* nodejs less compier & js minifier included
* using bower for 3rd party libraries

### Bugfixes
* [6434 - Strange sidebar layout on list.tpl](https://bugs.oxid-esales.com/view.php?id=6434)
* [6441 - resource not found: js/libs/cookie/jquery.cookie.min.js](https://bugs.oxid-esales.com/view.php?id=6441)
* [6442 - Sticky Navigation in Full-Width Layout](https://bugs.oxid-esales.com/view.php?id=6442)
* [6509 - articles with one or more pick lists are put into basket every time one chooses a setting](https://bugs.oxid-esales.com/view.php?id=6509)


### Removed / Replaced JS scritps and libraries:
* jQuery-UI removed
* Bootstrap-Select removed
* jquery cookie removed because smarty can do the job, too.
* jQuery-Bootstrap-Validation (discontinued) -> [BootstrapValidator](https://github.com/nghuuphuoc/bootstrapvalidator/)
* Photoswipe (lack of features) -> [FancyBox](http://fancyapps.com/fancybox/)


