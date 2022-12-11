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
        primary: colors.sky,
        secondary: colors.sky,
        // emerald: colors.emerald,
        // rose: colors.rose,
        // orange: colors.orange,
        // violet: colors.violet,
        // sky: colors.sky,
      },
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms'),
  ]
}
