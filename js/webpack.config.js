const path = require('path')

// webpack.config.js

module.exports = {
  entry: './src/main.js',
  output: {
    path: path.resolve(__dirname, "./dist"),
    filename: 'bundle.min.js'
  },
  devServer: {
    contentBase: path.resolve(__dirname, 'public')
  },
  resolve: {
    alias: {
	  vue: 'vue/dist/vue.js'
    }
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        loader: 'babel-loader',
        exclude: /node_modules/
      },
	  {
	    test: /\.(scss|css)$/,
		use: ["vue-style-loader", "css-loader", "sass-loader"]
	  },
	  {
        test: /\.(png|woff|woff2|eot|ttf|svg)$/,
        loader: 'file-loader?name=[name].[ext]'
      }
    ]
  }
}