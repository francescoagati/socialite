require "#{Rails.root}/lib/html_to_coderay"

module ApplicationHelper
  MARKDOWN_OPTIONS = { :autolink => true, :space_after_headers => true, :fenced_code_blocks => true }

  def markdown(text)
    markdown = Redcarpet::Markdown.new(HTMLWithCoderay, MARKDOWN_OPTIONS)
    markdown.render(text).html_safe
  end

  def readme_to_markdown
    markdown(File.read(File.join(Rails.root,'..','..', "README.md")))
  end
end
