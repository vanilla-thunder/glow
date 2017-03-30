var fs = require('fs'),
    util = require('util'),
    less = require('less'),
    LessPluginCleanCSS = require('less-plugin-clean-css'),
    ujs = require("uglify-js"),
    path = require('path'),
//ProgressBar = require('progress'),
    watch = require('node-watch');


// ********** Compiler config
var flowless = '../../' + (__dirname.indexOf('application/views/glow/out/glow') > -1 ? '../' : 'application/views/' ) + 'flow/build/less/',
    $vendor = path.join(__dirname, flowless), // relative path to flow less files
    $lessdir = path.join(__dirname, 'src/less/'), // watch this directory for file changes
    $lesssourcemap = true, // include source map or not? true / false
    $lessminify = false, // minify output? true / false
    $criticalsource = path.join(__dirname, 'src/less/glow.less'), // less source file relative to this file
    $criticaltarget = path.join(__dirname, 'src/css/glow.min.css'), //  target file for compilation relative to this file
    $asyncsource = path.join(__dirname, 'src/less/async.less'), // less source file relative to this file
    $asynctarget = path.join(__dirname, 'src/async.min.css'); //  target file for compilation relative to this file
// ********************************************************

// ********** UglifyJS config
var $jsdir = path.join(__dirname, 'src/js/'), // watch this directory for file changes
    $jstarget = path.join(__dirname, 'src/js/glow.min.js'), // target for compressed js ouput
    $jsbeautify = false, // js beautifier
    $jsmangle = true, // mangle function names? true / false
    $jssourcemap = false; // include source map or not? true / false

// ********************************************************

var dev = false;
if(process.argv && process.argv[2] == '--dev')
{
    dev = true;
    console.log('');
    console.log('   >> starting with dev configuration');
    // less
    $lesssourcemap = true;
    $lessminify = false;
    // js
    $jsbeautify = true;
    $jsmangle = false;
    $jssourcemap = true;
}

less.logger.addListener({
    debug: function (msg) {
        console.log("  ### debug : " + msg);
    },
    info: function (msg) {
        console.log("  ### info : " + msg);
    },
    warn: function (msg) {
        console.log("  ### warning : " + msg);
    },
    error: function (msg) {
        console.log("  ### error : " + msg);
    }
});

var cleanCSSPlugin = new LessPluginCleanCSS({
    advanced: true,
    keepSpecialComments: 0
});

var compile = function ($source, $target) {
    console.log('  > reading ' + path.basename($source) + ' ... ');
    fs.readFile($source, function (err, data) {
        if (err) {
            console.log('  > could not read ' + path.basename($source));
            return;
        }
        console.log('  > compiling ' + path.basename($source) + ' ... ');
        //console.log(data.toString());
        //bar.tick(2,{'token': "compiling less ..."});
        less.render(
            data.toString(),
            {
                plugins: [cleanCSSPlugin],
                paths: [__dirname, $vendor],
                filename: $source,
                //compress: $lessminify,
                sourceMap: {
                    sourceMapFileInline: $lesssourcemap,
                    sourceMapLessInline: $lesssourcemap,
                    outputSourceFiles: true
                    //sourceMapRootpath: '/',
                    //sourceMapBasepath: 'application/views'
                }
            })
            .then(
                function (output) {
                    //console.log(Object.getOwnPropertyNames(output).sort());
                    //console.log(output);
                    //bar.tick(3,{'token': "writing css ..."});
                    console.log('  > writing ' + path.basename($target) + ' ... ');
                    fs.writeFileSync($target, output.css);
                    //bar.tick(4,{'token': $target + ' updated'});
                    console.log('  > ' + path.basename($target) + ' updated');
                },
                function (error) {
                    //bar.tick(7,{'token': "aborted"});
                    console.log(' ---------- ERROR # \n' + e + '\n ---------- ERROR #');
                });
    });
};
var walkSync = function (dir, filelist) {
    fs.readdirSync(dir).forEach(function (file) {
        filelist = fs.statSync(path.join(dir, file)).isDirectory()
            ? walkSync(path.join(dir, file), filelist)
            : filelist.concat(path.join(dir, file));

    });
    return filelist.filter(function (file) {
        return file.indexOf('.min.js') === -1;
    });
};
var mergeJS = function () {
    var libs = [
        "src/libs/jquery/dist/jquery.min.js",
        (dev ? "src/libs/bootstrap/dist/js/bootstrap.js" : "src/libs/bootstrap/dist/js/bootstrap.min.js"),
        (dev ? "src/libs/bootstrapvalidator/dist/js/bootstrapValidator.js" : "src/libs/bootstrapvalidator/dist/js/bootstrapValidator.min.js"),
        "src/libs/bootstrapvalidator/dist/js/language/de_DE.js",
        "src/libs/jquery-mousewheel/jquery.mousewheel.js",
        "src/libs/jquery-unveil/jquery.unveil.js",
        "src/libs/matchheight/jquery.matchHeight.js",
        "src/libs/flexslider/jquery.flexslider-min.js",
        "src/libs/fancyBox/source/jquery.fancybox.js",
        "src/libs/outdated-browser/outdatedbrowser/outdatedbrowser.js"
    ];
    var files = walkSync(path.relative(__dirname, $jsdir), []);
    //console.log(libs.concat(files));

    js = ujs.minify(
        libs.concat(files),
        {
            compress: false,
            beautify: $jsbeautify,
            mangle: $jsmangle,
            sourceMapInline: $jssourcemap

        });
     fs.writeFileSync($jstarget, js.code);
      /*
    var AST = null;
    files.forEach(function(file){
        var code = fs.readFileSync(file, "utf8");
        AST = ujs.parse(
            code,
            {
                filename: file,
                toplevel: AST
            });
    });
    console.log(AST.print_to_string());
    fs.writeFileSync($jstarget, util.format(AST) + '\n');
    */
    //bar.tick(4,{'token': $target + ' updated'});
    console.log('  > ' + path.relative(__dirname, $jstarget) + ' updated');
};
// Benutzereingaben abfertigen
var stdin = process.openStdin();
stdin.addListener("data", function (d) {
    // note:  d is an object, and when converted to a string it will end with a linefeed.
    // so we (rather crudely) account for that with toString() and then substring()
    var cmd = d.toString().trim();
    if (cmd == "l" || cmd == "less") compile($criticalsource, $criticaltarget);
    else if (cmd == "j" || cmd == "js") mergeJS();
    else if (cmd == "min") {
        $lessminify = !$lessminify;
        console.log('  > minify set to: ' + $lessminify);
        compile($criticalsource, $criticaltarget);
    }
    else if (cmd == "map") {
        $lesssourcemap = !$lesssourcemap;
        console.log('  > sourcemap set to: ' + $lesssourcemap);
        compile($criticalsource, $criticaltarget);
    }
    else if (cmd == "beautify" || cmd == "b") {
        $jsbeautify = !$jsbeautify;
        console.log('  > js beautifier set to: ' + $jsbeautify);
        mergeJS();
    }
    else if (cmd == "mangle") {
        $jsmangle = !$jsmangle;
        console.log('  > js mangle set to: ' + $jsmangle);
        mergeJS();
    }
    else if (cmd == "jsmap") {
        $jssourcemap = !$jssourcemap;
        console.log('  > js sourcemap set to: ' + $jssourcemap);
        mergeJS();
    }


    else {
        console.log('');
        console.log(' | type "l" or "less" to compile less files');
        console.log(' | type "map" to toggle less sorucemap on and off ');
        console.log(' | type "min" to toggle minifying css on and off ');
        console.log(' |');
        console.log(' | type "beautify" to toggle js beautifier on and off');
        console.log(' | type "mangle" to toggle mangle js names on and off');
        console.log(' | type "jsmap" to toggle js sourcemap on and off');
        //console.log('  less directory:   ' + $watch);
        //console.log('');
        //console.log('  source: ' + $source);
        //console.log('  target: ' + $target);
        //console.log('');
        //console.log('');
    }
});
console.log('');
console.log('  _________________________________________________   LESS');
console.log(' |');
console.log(' | type "l" or "less" to compile less files');
console.log(' | type "m" or "minify" to toggle minifying css on and off ');
console.log(' |');
console.log(' |    flow less dir: ' + $vendor);
console.log(' |   less directory: ' + path.relative(path.join(__dirname, '../../'), $lessdir));
console.log(' |');
console.log(' |  critical source: ' + path.relative(path.join(__dirname, '../../'), $criticalsource));
console.log(' |  critical output: ' + path.relative(path.join(__dirname, '../../'), $criticaltarget));
console.log(' |');
console.log(' |     async source: ' + path.relative(path.join(__dirname, '../../'), $asyncsource));
console.log(' |     async output: ' + path.relative(path.join(__dirname, '../../'), $asynctarget));
console.log(' |');
console.log(' |           minify: ' + $lessminify);
console.log(' |        sourcemap: ' + $lesssourcemap);
console.log(' |');
console.log(' |_____________________________________________   UglifyJS');
console.log(' |');
console.log(' |        js target: ' + path.relative(path.join(__dirname, '../../'), $jstarget));
console.log(' |     js directory: ' + path.relative(path.join(__dirname, '../../'), $jsdir));
console.log(' |');
console.log(' |         beautify: ' + $jsbeautify);
console.log(' |           mangle: ' + $jsmangle);
console.log(' |        sourcemap: ' + $jssourcemap);
console.log(' |________________________________________________________');
console.log('');

// file and directory watchers
watch($lessdir, function (filename) {
    if (path.extname(filename) == '.less') {
        fs.stat(filename, function (err, stat) {
            if (err !== null) return;
            console.log('');
            console.log('  [ ' + new Date().toLocaleTimeString() + ' ] ' + path.basename(filename) + ' changed');

            //if (path.basename(filename) == path.basename($criticalsource) || path.basename(filename).indexOf('critical') !== -1) compile($criticalsource, $criticaltarget);
            //else if (path.basename(filename) == path.basename($asyncsource) || path.basename(filename).indexOf('async') !== -1) compile($asyncsource, $asynctarget);
            compile($criticalsource, $criticaltarget);
        });
    }
});

// js watchers
watch($jsdir, function (filename) {
    if (path.basename(filename).indexOf('.min') !== -1 || path.extname(filename) !== '.js') return;
    fs.stat(filename, function (err, stat) {
        if (err !== null) return;
        console.log('');
        console.log('  [ ' + new Date().toLocaleTimeString() + ' ] ' + path.relative(__dirname, filename) + ' changed');
        mergeJS();
    });

});