const path = require('path');
const webpack = require('webpack')

module.exports = {
  mode: 'production',
  module: {
    rules: [
      {
        test: /\.coffee$/,
        use: 'coffee-loader'
      }
    ],
  },
  externals: [
    'date-fns'
  ],
  entry: './src/index.coffee',
  output: {
    library: 'date-queries',
    libraryTarget: 'umd',
    filename: 'index.js',
    path: path.resolve(__dirname, 'dist')
  },
  resolve: {
    extensions: ['.coffee', '.js']
  }
};
