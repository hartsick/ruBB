class SiteTheme
    def self.pick_color(number)
        color_wheel = %w[
            bg-sky-500
            bg-sky-400
            bg-sky-300
            bg-sky-200
            bg-sky-100
            bg-sky-200
            bg-sky-300
            bg-sky-400
        ]

        index = number % color_wheel.length
        color_wheel[index]
    end
end
