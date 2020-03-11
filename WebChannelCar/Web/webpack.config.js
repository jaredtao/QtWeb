const path = require('path');

module.exports = {
  mode: 'development',
  entry: './src/main.ts',
  devtool: 'eval-source-map',
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: [{
          loader: 'expose-loader',
          options: 'Library'
        }, {
          loader: 'ts-loader'
        }],
        exclude: /node_modules/
      }
    ]
  },
  resolve: {
    extensions: ['.tsx', '.ts', '.js'],
  },
  output: {
    filename: 'main.js',
    path: path.resolve(__dirname, 'out')
    
  }
};