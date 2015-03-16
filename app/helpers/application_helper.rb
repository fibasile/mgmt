module ApplicationHelper
  def title(page_title, options={})
    content_for(:title, page_title.to_s)
    return content_tag(:h1, page_title, options.merge(itemprop: "name"))
  end

  def crumbs(*args)
    content_for(:title, args.last.to_s)
    return content_tag(:h1, args.join(' / ').html_safe)
  end

  def full_grade(value)
    value ? sprintf('%.2f', value) : "-"
  end
end
