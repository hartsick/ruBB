class SiteTheme
    def self.pick_color(number)
        color_wheel = %w[
            bg-fuchsia-100
            bg-orange-100
            bg-yellow-100
            bg-lime-100
            bg-teal-100
            bg-lime-100
            bg-yellow-100
            bg-orange-100
        ]

        index = number % color_wheel.length
        color_wheel[index]
    end
end
