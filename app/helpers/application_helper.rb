module ApplicationHelper

  def full_title(page_title='')
    base_title = 'Learning Ruby'

    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def custom_paginate_renderer()
    # bootstrap 4
    Class.new(WillPaginate::ActionView::LinkRenderer) do
    def container_attributes
      { class: "pagination justify-content-center" }
    end
  
    def page_number(page)
      if page == current_page
        "<li class=\"page-item active\">" + link(page, page, rel: rel_value(page), class: 'page-link') + "</li>"
      else
        "<li class=\"page-item\">" + link(page, page, rel: rel_value(page), class: 'page-link') + "</li>"
      end
    end
  
    def previous_page
      num = @collection.current_page > 1 && @collection.current_page - 1
      previous_or_next_page(num, "<span aria-hidden=\"true\">&laquo;</span>
        <span class=\"sr-only\">Previous</span>")
    end
  
    def next_page
      num = @collection.current_page < total_pages && @collection.current_page + 1
      previous_or_next_page(num, "<span aria-hidden=\"true\">&raquo;</span>
        <span class=\"sr-only\">Next</span>")
    end
  
    def previous_or_next_page(page, text)
      if page
        "<li class=\"page-item\">" + link(text, page, class: 'page-link') + "</li>"
      else
        "<li class=\"page-item disabled\">" + link(text, '#', class: 'page-link') + "</li>"
      end
    end
    end
  end

end
