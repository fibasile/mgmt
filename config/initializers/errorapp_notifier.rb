if Rails.env.production?
  require 'errorapp_notifier'
  ErrorappNotifier.configure do|config|
    config.api_key = ENV['ERRORAPP_API_KEY']
  end
end
