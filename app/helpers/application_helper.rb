module ApplicationHelper
    def title(text)
        content_for :title, text
    end
end
