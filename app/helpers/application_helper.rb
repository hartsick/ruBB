module ApplicationHelper
    def title(text)
        content_for :title, text
    end

    def disable_cache
        content_for :cache_control, '<meta name="turbo-cache-control" content="no-cache">'.html_safe
    end
end
