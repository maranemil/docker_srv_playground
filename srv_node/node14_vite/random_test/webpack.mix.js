const mix = require('laravel-mix');
const glob = require('glob');
const path = require('path');
const ReplaceInFileWebpackPlugin = require('replace-in-file-webpack-plugin');
const rimraf = require('rimraf');
const del = require('del');
const fs = require('fs');/*
 |--------------------------------------------------------------------------
 | Mix Asset Management
 |--------------------------------------------------------------------------
 |
 | Mix provides a clean, fluent API for defining some Webpack build steps
 | for your Laravel applications. By default, we are compiling the CSS
 | file for the application as well as bundling up all the JS files.
 |
 */// arguments/params from the line command
const args = getParameters();mix.options({
 cssNano: {
 discardComments: false,
 }
});// Remove existing generated assets from public folder
del.sync(['public/css/*', 'public/js/*', 'public/media/*', 'public/plugins/*',]);// Build 3rd party plugins css/js
mix.sass(`resources/src/webpack/plugins/plugins.scss`, `public/assets/plugins/global/plugins.bundle.css`).then(() => {
 // remove unused preprocessed fonts folder
 rimraf(path.resolve('public/fonts'), () => {
 });
 rimraf(path.resolve('public/images'), () => {
 });
}).sourceMaps(!mix.inProduction())
 // .setResourceRoot('./')
 .options({processCssUrls: false}).js([`resources/src/webpack/plugins/plugins.js`], `public/assets/plugins/global/plugins.bundle.js`);// Build extended plugin styles
mix.sass(`resources/src/sass/plugins.scss`, `public/assets/plugins/global/plugins-custom.bundle.css`);mix.sass(`resources/src/sass/style.scss`, `public/assets/css/style.bundle.css`, {sassOptions: {includePaths: ['node_modules']}})
 // .options({processCssUrls: false})
 .js([`resources/src/webpack/scripts.js`], `public/assets/js/scripts.bundle.js`);mix.js('./resources/src/js/widgets/**/!(_)*.js', 'public/assets/js/widgets.bundle.js');
// Dark skin mode css files
if (args.indexOf('dark_mode') !== -1) {
 mix.sass(`resources/src/plugins/plugins.dark.scss`, `public/assets/plugins/global/plugins.dark.bundle.css`);
 mix.sass(`resources/src/sass/plugins.dark.scss`, `public/assets/plugins/global/plugins-custom.dark.bundle.css`);
 mix.sass(`resources/src/sass/style.dark.scss`, `public/assets/css/style.dark.bundle.css`, {sassOptions: {includePaths: ['node_modules']}});
}
// Build custom 3rd party plugins
(glob.sync(`resources/src/plugins/custom/**/*.js`) || []).forEach(file => {
 mix.js(file, `public/assets/${file.replace(`resources/src/`, '').replace('.js', '.bundle.js')}`);
});
(glob.sync(`resources/src/plugins/custom/**/*.scss`) || []).forEach(file => {
 mix.sass(file, `public/assets/${file.replace(`resources/src/`, '').replace('.scss', '.bundle.css')}`);
});(glob.sync(`resources/src/sass/pages/**/!(_)*.scss`) || []).forEach(file => {
 file = file.replace(/[\\\/]+/g, '/');
 mix.sass(file, file.replace(`resources/src/sass`, `public/assets/css`).replace(/\.scss$/, '.css'));
});var extendedFiles = [];
// Extend custom js files for laravel
(glob.sync('resources/src/extended/js/**/*.js') || []).forEach(file => {
 var output = `public/assets/${file.replace('resources/src/extended/', '')}`;
 mix.js(file, output);
 extendedFiles.push(output);
});(glob.sync('resources/src/js/custom/**/*.js') || []).forEach(file => {
 var output = `public/assets/${file.replace('resources/src/', '')}`;
 if (extendedFiles.indexOf(output) === -1) {
 mix.js(file, output);
 }
});mix.copyDirectory('resources/src/media', `public/assets/media`);
mix.copyDirectory(`resources/src/media`, `public/assets/media`);(glob.sync(`resources/src/sass/themes/**/!(_)*.scss`) || []).forEach(file => {
 file = file.replace(/[\\\/]+/g, '/');
 mix.sass(file, file.replace(`resources/src/sass`, `public/assets/css`).replace(/\.scss$/, '.css'));
});let plugins = [
 new ReplaceInFileWebpackPlugin([
 {
 // rewrite font paths
 dir: path.resolve(`public/assets/plugins/global`),
 test: /\.css$/,
 rules: [
 {
 // fontawesome
 search: /url\((\.\.\/)?webfonts\/(fa-.*?)"?\)/g,
 replace: 'url(./fonts/@fortawesome/$2)',
 },
 {
 // flaticon
 search: /url\(("?\.\/)?font\/(Flaticon\..*?)"?\)/g,
 replace: 'url(./fonts/flaticon/$2)',
 },
 {
 // flaticon2
 search: /url\(("?\.\/)?font\/(Flaticon2\..*?)"?\)/g,
 replace: 'url(./fonts/flaticon2/$2)',
 },
 {
 // keenthemes fonts
 search: /url\(("?\.\/)?(Ki\..*?)"?\)/g,
 replace: 'url(./fonts/keenthemes-icons/$2)',
 },
 {
 // lineawesome fonts
 search: /url\(("?\.\.\/)?fonts\/(la-.*?)"?\)/g,
 replace: 'url(./fonts/line-awesome/$2)',
 },
 {
 // socicons
 search: /url\(("?\.\.\/)?font\/(socicon\..*?)"?\)/g,
 replace: 'url(./fonts/socicon/$2)',
 },
 {
 // bootstrap-icons
 search: /url\(.*?(bootstrap-icons\..*?)"?\)/g,
 replace: 'url(./fonts/bootstrap-icons/$1)',
 },
 ],
 },
 ]),
];mix.webpackConfig({
 plugins: plugins,
 ignoreWarnings: [{
 module: /esri-leaflet/,
 message: /version/,
 }],
 resolve: {
 alias: {
 "@": path.resolve(__dirname, "resources/"),
 'handlebars': 'handlebars/dist/handlebars.js',
 },
 extensions: ['.js', '.scss'],
 fallback: {
 util: false,
 },
 }
});// Webpack.mix does not copy fonts, manually copy
(glob.sync(`resources/src/plugins/**/*.+(woff|woff2|eot|ttf)`) || []).forEach(file => {
 var folder = file.match(/resources\/src\/plugins\/(.*?)\//)[1];
 mix.copy(file, `public/assets/plugins/global/fonts/${folder}/${path.basename(file)}`);
});
(glob.sync('node_modules/+(@fortawesome|socicon|line-awesome|bootstrap-icons)/**/*.+(woff|woff2|eot|ttf)') || []).forEach(file => {
 var folder = file.match(/node_modules\/(.*?)\//)[1];
 mix.copy(file, `public/assets/plugins/global/fonts/${folder}/${path.basename(file)}`);
});// Raw plugins
(glob.sync(`resources/src/plugins/custom/**/*.js.json`) || []).forEach(file => {
 let filePaths = JSON.parse(fs.readFileSync(file, 'utf-8'));
 const fileName = path.basename(file).replace('.js.json', '');
 mix.scripts(filePaths, `public/assets/plugins/custom/${fileName}/${fileName}.bundle.js`);
});function getParameters() {
 var possibleArgs = [
 'dark_mode'
 ];
 for (var i = 0; i <= 13; i++) {
 possibleArgs.push('demo' + i);
 } var args = [];
 possibleArgs.forEach(function (key) {
 if (process.env['npm_config_' + key]) {
 args.push(key);
 }
 });
 return args;
}