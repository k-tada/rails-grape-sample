require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Sample
  class Application < Rails::Application
    # app/apis 以下の.rbファイルを対象に追加。
    config.paths.add File.join('app', 'apis'), glob: File.join('**', '*.rb')

    # app/apis 以下のファイルをオートロード対象に追加
    config.autoload_paths += Dir[Rails.root.join('app', 'apis', '*')]

    # JBuilder用のViewパスを追加
    config.middleware.use(Rack::Config) do |env|
      env['api.tilt.root'] = Rails.root.join 'app', 'views', 'apis'
    end
  end
end
