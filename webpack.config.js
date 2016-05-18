module.exports = {
  module: {
    loaders: [{
      test: /\.elm$/,
      exclude: [/elm-stuff/, /node_modules/],
      loader: 'elm-webpack?pathToMake=./node_modules/.bin/elm-make'
    }]
  }
}
