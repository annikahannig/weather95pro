
let config = require('./webpack.config')

// Configure webpack-dev-server
config.devServer = {
  inline: true,
  stats: { colors: true },
  contentBase: "./build/"
};

module.exports = config;
