const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");

module.exports = {
  entry: path.resolve(__dirname, "src/index.js"),
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "index_bundle.js",
    library: {
      name: "$",
      type: "umd",
    },
  },
  devtool: "source-map",
  devServer: {
    static: "./dist",
    port: 9000,
  },
  plugins: [new HtmlWebpackPlugin({ title: "Test" })],
  mode: "development",
};