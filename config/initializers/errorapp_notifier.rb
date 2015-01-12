if Rails.env.production?
  ErrorappNotifier.configure do|config|
    config.api_key = ENV['ERRORAPP_API_KEY']
  end
end
