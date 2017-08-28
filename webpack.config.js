
/*
 * Webpack Configuration for Mete95.exe
 *
 */

const webpack = require('webpack');
const path    = require('path');

const TransferWebpackPlugin = require('transfer-webpack-plugin');

const nodeModulesPath = path.resolve(__dirname, 'node_modules');
const buildPath       = path.resolve(__dirname, 'build');

const config = {
  entry: {
    app: [
      path.join(__dirname, '/src/app.js')
    ]
  },

  output: {
    path: buildPath,
    filename: 'app.js',
  },

  plugins: [
    new webpack.NoEmitOnErrorsPlugin(),
    new TransferWebpackPlugin([
      {from: 'public'},
    ], path.resolve(__dirname, 'src')),
  ],


  module: {
    rules: [
      // ELM loader
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: 'elm-webpack-loader?verbose=true&warn=true'
      },
    ]
  }
};


module.exports = config;

