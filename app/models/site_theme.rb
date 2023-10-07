class SiteTheme
    def self.pick_color(number)
        color_wheel = %w[
            bg-amber-600
            bg-amber-500
            bg-amber-400
            bg-amber-300
            bg-amber-200
        ]

        index = number % color_wheel.length
        color_wheel[index]
    end
end
