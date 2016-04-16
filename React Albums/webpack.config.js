var path = require('path');
var webpack = require('webpack');

module.exports = {
    devtool: 'cheap-module-inline-source-map',
    entry: [
        'webpack-hot-middleware/client',
        path.join(__dirname, 'src', 'web', 'index.js')
    ],
    output: {
        path: path.join(__dirname, 'dist'),
        filename: 'bundle.js',
        publicPath: '/static/'
    },
    plugins: [
        new webpack.HotModuleReplacementPlugin()
    ],
    module: {
        loaders: [{
            test: /\.jsx?$/,
            loaders: ['babel-loader'],
            include: path.join(__dirname, 'src')
        }]
    }
};