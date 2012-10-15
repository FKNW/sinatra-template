class App < Sinatra::Base
  set :public_folder, 'public'
  set :views, 'views'

  helpers Sinatra::ContentFor
  helpers Sprockets::Helpers

  set :sprockets, Sprockets::Environment.new
  configure do
    set :site_title, ENV['SITE_TITLE']

    Sprockets::Helpers.configure do |config|
      config.environment = sprockets
      config.prefix = '/assets'
      config.digest = true
    end
    sprockets.append_path 'assets/javascripts'
    sprockets.append_path 'assets/stylesheets'
    sprockets.append_path 'assets/images'
    if production?
      sprockets.js_compressor = YUI::JavaScriptCompressor.new(munge: true, optimize: true)
      sprockets.css_compressor = YUI::CssCompressor.new
    end
  end
  
  before '/*.json' do
    content_type 'application/json'
  end

end
