Rails.application.config.session_store :cookie_store, key: '_your_app_session'
# Rails.application.config.session_store :cookie_store, expire_after: 14.days {
    # :key => 'A2A',
    # :domain => :all,
    # :same_site => :none,
    # :secure => :true,
    # :tld_length => 2
  # }