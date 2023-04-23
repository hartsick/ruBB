const colors = require('tailwindcss/colors')

module.exports = {
  content: [
    './app/models/site_theme.rb',
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/javascript/application.js'
  ],
  theme: {
    extend: {
      colors: {
        primary: colors.green,
        secondary: colors.yellow,
      },
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms'),
  ]
}
