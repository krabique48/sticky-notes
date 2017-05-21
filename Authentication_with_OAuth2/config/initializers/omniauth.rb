Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  
  provider :identity, on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }

  provider :vkontakte, ENV['VKONTAKTE_KEY'], ENV['VKONTAKTE_SECRET'],
           lang: 'en'

  provider :facebook, ENV["FACEBOOK_KEY"], ENV["FACEBOOK_SECRET"], :provider_ignores_state => true,
           scope: 'public_profile', info_fields: 'id,name,link'
          

  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_SECRET"],
           scope: 'profile', image_aspect_ratio: 'square', image_size: 48, access_type: 'online', name: 'google',
           access_type: "offline", skip_jwt: true

  provider :linkedin, ENV["LINKEDIN_KEY"], ENV["LINKEDIN_SECRET"],
           scope: 'r_basicprofile'
           #fields: ['id', 'first-name', 'last-name', 'location', 'picture-url', 'public-profile-url']

  OmniAuth.config.on_failure = Proc.new do |env|
    SessionsController.action(:auth_failure).call(env)
     error_type = env['omniauth.error.type']
     new_path = "#{env['SCRIPT_NAME']}#{OmniAuth.config.path_prefix}/failure?message=#{error_type}"
     [301, {'Location' => new_path, 'Content-Type' => 'text/html'}, []]
  end
end