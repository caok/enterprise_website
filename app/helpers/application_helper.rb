module ApplicationHelper
  #def markdown(content)
    #rndr = Redcarpet::Render::HTML.new(:no_links => true, :hard_wrap => true, :filter_html => true)
    #markdown = Redcarpet::Markdown.new(rndr,
      #:autolink => true, :space_after_headers => true, :strikethrough => true)
    #raw markdown.render(content)
  #end
  def markdown(str, options = {})
    options[:hard_wrap] ||= false
    options[:class] ||= ''
    assembler = Redcarpet::Render::HTML.new(:hard_wrap => options[:hard_wrap]) # auto <br> in <p>

    renderer = Redcarpet::Markdown.new(assembler, {
      :autolink => true,
      :fenced_code_blocks => true
    })
    content_tag(:div, raw(MarkdownConverter.convert(str)), :class => options[:class])
  end

  def format_pic_url(url)
    "![](" + url + ")"
  end
end
