class SiteTheme
    COLOR_WHEEL = %w[
        bg-emerald-100
        bg-sky-100
        bg-violet-100
        bg-rose-100
        bg-pink-100
        bg-orange-100
        bg-gray-100
    ]

    def self.pick_color(number)
        index = number % COLOR_WHEEL.length
        COLOR_WHEEL[index]
    end
end