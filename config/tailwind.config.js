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
        stone: colors.stone,
        yellow: colors.yellow,
        amber: colors.amber,
        orange: colors.orange,
        primary: colors.amber,
        secondary: colors.stone,
      },
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms'),
  ]
}
