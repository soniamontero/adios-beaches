const { environment } = require('@rails/webpacker')

const webpack = require('webpack')

// Preventing Babel from transpiling NodeModules packages
environment.loaders.delete('nodeModules');

// Bootstrap 4 has a dependency over jQuery & Popper.js:
// environment.plugins.append("Provide", new webpack.ProvidePlugin({
//   $: 'jquery',
//   jQuery: 'jquery',
//   Popper: ['popper.js', 'default']
// }));

environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    jQuery: 'jquery',
    jquery: 'jquery',
    $: 'jquery',
    Popper: ['popper.js', 'default']
  })
)

// environment.loaders.append('jquery', {
//   test: require.resolve('jquery'),
//   use: [{
//     loader: 'expose-loader',
//     options: '$',
//   }, {
//     loader: 'expose-loader',
//     options: 'jQuery',
//   }],
// });

module.exports = environment

