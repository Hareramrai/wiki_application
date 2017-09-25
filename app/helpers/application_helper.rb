module ApplicationHelper
  def markdown(text)
    options = {
      filter_html: true,
      hard_wrap: true,
      line_numbers: true,
      link_attributes: { rel: 'nofollow', target: "_blank" }
    }

    extensions = {
      autolink: true,
      disable_indented_code_blocks: true,
      fenced_code_blocks: true,
      highlight: true,
      no_intra_emphasis: true,
      superscript: true,
      strikethrough: true,
      space_after_headers: true
    }
    renderer = Highlight::HTML.new(options)
    Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
  end

  def format_time time
    time.strftime(' %A, %d %b %Y %l:%M %p')
  end

  def time_with_icon time
    content_tag(:i, nil, class: "glyphicon glyphicon-calendar") + format_time(time)
  end

  def email_with_icon email 
    content_tag(:i, nil, class: "glyphicon glyphicon-user") +  " By #{email}"
  end

  def article_count tag
    "#{tag.name}  #{content_tag(:span, tag.count, class: 'badge badge-info')}".html_safe
  end
end
