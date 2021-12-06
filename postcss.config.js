module.exports = {
  plugins: [
    require('postcss-import'),
    require('tailwindcss')('./app/assets/stylesheets/tailwind.config.js'),
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    })
  ]
}
