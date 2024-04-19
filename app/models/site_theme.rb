class SiteTheme
    def self.pick_color(number)
        color_wheel = %w[
            bg-amber-100
            bg-amber-200
            bg-amber-300
            bg-amber-200
            bg-amber-100
            bg-rose-100
            bg-rose-200
            bg-rose-300
            bg-rose-200
            bg-rose-100
            bg-cyan-100
            bg-cyan-200
            bg-cyan-300
            bg-cyan-200
            bg-cyan-100
            bg-rose-100
            bg-rose-200
            bg-rose-300
            bg-rose-200
            bg-rose-100
        ]

        index = number % color_wheel.length
        color_wheel[index]
    end
end
