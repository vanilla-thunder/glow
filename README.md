# Glow responsive Theme für OXID eShop
**demo: [http://glow.mb-dev.pro](http://glow.mb-dev.pro)**  
basierend auf Flow Theme: https://github.com/OXID-eSales/flow_theme

### Getestete / kompatible Module:
- Payment:
    * [D³ Heidelpay Integrator](https://www.oxidmodule.com/OXID-eShop/Module/Heidelpay-Integrator-fuer-Oxid-PE.html): Kreditkarte, Lastschrift, Paypal, SOfortüberweisung, Rechnung
    * [ecomponents Paypal Gateway](https://www.ecomponents.de/module/paypal-gateway-inkl-express-und-paypal-plus/)
- Andere:
    * [D³ File Upload](https://www.oxidmodule.com/OXID-eShop/Module/File-Upload-fuer-Oxid-PE.html)

### Aktuelle To-Do Liste
* Formular Validierung für E-Mail Adressen, PLZ, etc
* Aggrosoft Paypal und OXID Paypal+ testen

### benötigte Module
* [vt-themesettings](https://github.com/vanilla-thunder/themesettings) für Theme Einstellungen. pflicht!
* [vt-childtplmod](https://github.com/vanilla-thunder/childtplmod) Das Theme enthält bereits angepasste Templates für einige Module.  
Damit diese geladen werden, wird dieses Modul benötigt.

### Installation
    cd application/views/
    git clone https://github.com/vanilla-thunder/glow.git
    ln -s ../application/views/glow/out/glow ../../out/glow
oder:
 1. Archiv herunterladen
 2. nach application/views/glow entpacken
 3. application/views/glow/out/glow nach out/glow kopieren

### Theme Einstellungen
- Icons: 100*100
- Thumbnails: 600*450
- Kategoriebild: 1300*300
- Zoom-Bilder: 1300*1000
- oxpic: 600*450
- Marken-Logos: 200*100
- Kategoriebild einer Unterkategorie: 400*100
- Promotion: 650*350

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
* live price update for amount prices https://glow.mb-dev.pro/Kiteboarding/Trapeze/Trapez-ION-MADTRIXX.html
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


