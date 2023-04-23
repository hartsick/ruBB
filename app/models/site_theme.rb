class SiteTheme
    def self.pick_color(number)
        color_wheel = %w[
            bg-emerald-100
            bg-sky-100
            bg-violet-100
            bg-rose-100
            bg-pink-100
            bg-orange-100
            bg-zinc-100
        ]

        index = number % color_wheel.length
        color_wheel[index]
    end
end
