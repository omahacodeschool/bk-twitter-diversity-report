OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'], 
  {
    :authorize_params => {
      :force_login => 'true'
    }
  }
end
