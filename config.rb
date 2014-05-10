###
# Blog settings
###

Time.zone = "Tokyo"

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  blog.prefix = "blog"

  # blog.permalink = "{year}/{month}/{day}/{title}.html"

  # Matcher for blog source files
  # ブログのソースは、blogディレクトリ配下に日付でディレクトリを分けて置くことにする。
  blog.sources = "{year}/{month}/{day}/{title}.html"

  # タグ毎のページには、ディレクトリでアクセスできるようにする。
  blog.taglink = "tags/{tag}/index.html"

  # ブログ記事用のレイアウトをlayouts/blogに用意する。
  blog.layout = "blog"

  # proxyで生成されるページのテンプレートは、blog/templatesディレクトリに配置する。
  blog.tag_template = "blog/templates/tag.html"
  blog.calendar_template = "blog/templates/calendar.html"

  # 日付毎とかのページは、ディレクトリでアクセスできるようにする。
  blog.year_link = "{year}/index.html"
  blog.month_link = "{year}/{month}/index.html"
  blog.day_link = "{year}/{month}/{day}/index.html"

  # .markdownは長いから、拡張子は.mdにする。
  blog.default_extension = ".md"

  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250

  # Enable pagination
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
#
# Atomのファイルにはレイアウト適用しないで。
page "/blog/atom.xml", layout: false


# With alternative layout
#
# A path which all have the same layout
# ブログ以外のページのレイアウトは、layouts/pageにする。
with_layout :page do
  page "/pages/*"
end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :slim, { format: :html5 }

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :markdown_engine, :redcarpet

# For example, change the Compass output style for deployment
activate :minify_css

# Minify Javascript on build
activate :minify_javascript

# Minify HTML on build
activate :minify_html

# Enable cache buster
activate :asset_hash

# Build-specific configuration
configure :build do
  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
