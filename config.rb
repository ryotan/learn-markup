################################################################################
# Blog settings
################################################################################

Time.zone = 'Tokyo'

activate :blog, {
  # ブログ記事は、/blogで公開する。ソースも/blog配下になる。
  prefix: '/blog',
  sources: '/{year}/{month}/{day}/{title}.html',

  # ブログ記事用のレイアウトをlayouts/blogに用意する。
  layout: 'blog',

  # proxyで生成されるページのテンプレートは、blog/templatesディレクトリに配置する。
  calendar_template: 'blog/templates/calendar.html',
  tag_template:      'blog/templates/tag.html',

  # 日付毎とかのページは、ディレクトリでアクセスできるようにする。
  year_link:  '{year}/index.html',
  month_link: '{year}/{month}/index.html',
  day_link:   '{year}/{month}/{day}/index.html',
  taglink:    '/tags/{tag}/index.html',

  # 拡張子markdownは長い。
  default_extension: '.md',

  # ページネーション
  paginate: true,
  per_page: 10,
  page_link: 'page{num}',
}


################################################################################
# Common configurations
################################################################################

set :css_dir, 'styles'
set :js_dir, 'scripts'
set :images_dir, 'images'

# Sprockets load path ###########################################################
after_configuration do
  # Bowerのインストール先ディレクトリをSprocketsのLoad Pathに追加する。
  @bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
  sprockets.append_path File.join "#{root}", @bower_config["directory"]
end


################################################################################
# Page options, layouts, aliases and proxies
################################################################################

# ブログ用のAtomにはレイアウト適用しないで。
page "/blog/atom.xml", layout: false

# ブログ以外のページのレイアウトは、layouts/pageにする。
with_layout :page do
  page "/pages/*"
end


################################################################################
# Template Engine
################################################################################

set :slim,
  format: :html5,   # HTML5のフォーマットで出力
  sort_attrs: false # 属性をソートしない


################################################################################
# Markdown Engine
################################################################################

set :markdown_engine, :redcarpet
set :markdown,
  no_intra_emphasis: true,   # no_intra_empasis の intra がemされないように
  tables: true,              # tableを書けるように
  fenced_code_blocks: true,  # GitHubスタイルの```rubyみたいなコードブロック
  autolink: true,            # URLを自動的にリンクに
  strikethrough: true,       # ~~で挟んだところをdelに
  lax_spacing: true,         # HTML要素の前後に空行がなくても、HTMLとして解釈
  space_after_headers: true, # ヘッダーの#の後ろにスペースを必須に
  superscript: true,         # 1^2でsup
  footnotes: true,           # [^1]とかで脚注を付けれるように
  smartypants: true          # ...が…になったり


################################################################################
# Middleman Plugins
################################################################################

# Syntax Highlight #############################################################
# middleman-syntax
activate :syntax, {
  line_numbers: true # 行番号を表示する。
}

# Autoprefixer #################################################################
# Add vendor specific css prefixes. (middleman-autoprefixer)
activate :autoprefixer


################################################################################
# Build-specific configuration
################################################################################
configure :build do
  # Use relative URLs for Assets
  activate :relative_assets

  # Minify CSS on build
  activate :minify_css

  # Minify JavaScript on build
  activate :minify_javascript

  # Minify HTML on build
  activate :minify_html

  # Enable cache buster
  activate :asset_hash

  # Compass ####################################################################
  # 出力されるCSSは、ビルド時には圧縮する。
  compass_config do |config|
    config.output_style = :compressed
  end
end


################################################################################
# Development-specific configuration
################################################################################
configure :development do
  # LiveReload #################################################################
  # WebSocketが使えるブラウザでは、Flashは使わないようにしておく。
  activate :livereload, { no_swf: true }

  # Slim #######################################################################
  # 出力されるHTMLをフォーマットするようにしとく。
  set :slim, pretty: true

  # Debugging ##################################################################
  # middleman server で起動しているときは、SprocketsのDebug Modeを使って、
  # bundleしないで、各ファイルを個別にロードするようにする。
  # Sprocketsのrequireで読み込んでるファイルは個別にロードされるようになるけど、
  # Sassの@importで読み込んでるファイルは、個別にロードされるようにはならない。
  set :debug_assets, true

  # Compass ####################################################################
  # 出力されるCSSをフォーマットするようにしとく。
  compass_config do |config|
    config.output_style = :expanded
  end
end
