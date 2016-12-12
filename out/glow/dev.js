var fs = require('fs'),
    less = require('less'),
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
    $criticalsource = path.join(__dirname, 'src/less/styles.less'), // less source file relative to this file
    $criticaltarget = path.join(__dirname, 'src/css/styles.min.css'), //  target file for compilation relative to this file
    $asyncsource = path.join(__dirname, 'src/less/async.less'), // less source file relative to this file
    $asynctarget = path.join(__dirname, 'src/css/async.min.css'); //  target file for compilation relative to this file
// ********************************************************

// ********** UglifyJS config
var $jsdir = path.join(__dirname, 'src/js/'), // watch this directory for file changes
    $jssourcemap = true, // include source map or not? true / false
    $jsmangle = true; // mangle function names? true / false

// ********************************************************

var $views = path.join(__dirname, flowless,'../../../'),
    $root = path.join($views,'../../');

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

var compile = function ($source,$target) {
    console.log('  > reading '+path.basename($source)+' ... ');
    fs.readFile($source, function (err, data) {
        if (err) {
            console.log('  > could not read ' + path.basename($source));
            return;
        }
        console.log('  > compiling '+path.basename($source)+' ... ');
        //console.log(data.toString());
        //bar.tick(2,{'token': "compiling less ..."});
        less.render(
            data.toString(),
            {
                paths: [__dirname, $vendor],
                filename: $source,
                compress: $lessminify,
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
                    console.log('  > writing '+path.basename($target)+' ... ');
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

// Benutzereingaben abfertigen
var stdin = process.openStdin();
stdin.addListener("data", function (d) {
    // note:  d is an object, and when converted to a string it will end with a linefeed.
    // so we (rather crudely) account for that with toString() and then substring()
    var cmd = d.toString().trim();
    if (cmd == "l" || cmd == "less") compile($criticalsource,$criticaltarget);
    else if (cmd == "min") {
        $lessminify = !$lessminify;
        console.log('  > minify set to: ' + $lessminify);
        compile($criticalsource,$criticaltarget);
    }
    else if (cmd == "map") {
        $lesssourcemap = !$lesssourcemap;
        console.log('  > sourcemap set to: ' + $lesssourcemap);
        compile($criticalsource,$criticaltarget);
    }
    else {
        console.log('');
        console.log(' | type "l" or "less" to compile less files');
        console.log(' | type "map" to toggle less sorucemap on and off ');
        console.log(' | type "min" to toggle minifying css on and off ');
        console.log(' |');
        console.log(' | type "mangle" to toggle mangle js names on and off');
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
console.log(' |   less directory: ' + path.relative(__dirname, $lessdir));
console.log(' |');
console.log(' |  critical source: ' + path.relative(__dirname, $criticalsource));
console.log(' |  critical output: ' + path.relative(__dirname, $criticaltarget));
console.log(' |');
console.log(' |     async source: ' + path.relative(__dirname, $asyncsource));
console.log(' |     async output: ' + path.relative(__dirname, $asynctarget));
console.log(' |');
console.log(' |        sourcemap: ' + $lesssourcemap);
console.log(' |           minify: ' + $lessminify);
console.log(' |');
console.log(' |_____________________________________________   UglifyJS');
console.log(' |');
console.log(' |     js directory: ' + path.relative(__dirname, $jsdir));
console.log(' |        sourcemap: ' + $jssourcemap);
console.log(' |           mangle: ' + $jsmangle);
console.log(' |________________________________________________________');
console.log('');

// file and directory watchers
watch($lessdir, function (filename) {
    if (path.extname(filename) == '.less') {
        fs.stat(filename, function (err, stat) {
            if (err !== null) return;
            console.log('');
            console.log('  [ ' + new Date().toLocaleTimeString() + ' ] ' + path.basename(filename) + ' changed');

            if(path.basename(filename) == path.basename($criticalsource) || path.basename(filename).indexOf('critical') !== -1) compile($criticalsource,$criticaltarget);
            else if(path.basename(filename) == path.basename($asyncsource) || path.basename(filename).indexOf('async') !== -1) compile($asyncsource,$asynctarget);
        });
    }
});

// file and directory watchers
watch($jsdir, function (filename) {
    if (path.basename(filename).indexOf('.min') == -1 && path.extname(filename) == '.js') {
        var src = path.relative(__dirname, filename),
            out = src.replace('.js', '.min.js'),
            js = '';
        //console.log('src: '+src);
        //console.log('out: '+out);

        fs.stat(filename, function (err, stat) {
            if (err !== null) return;
            console.log('');
            console.log('  [ ' + new Date().toLocaleTimeString() + ' ] ' + path.relative(__dirname, filename) + ' changed');
            js = ujs.minify([path.relative(__dirname, filename)]);
            fs.writeFileSync(out, js.code);
            //bar.tick(4,{'token': $target + ' updated'});
            console.log('  > ' + path.relative(__dirname, out) + ' updated');

        });
    }
});