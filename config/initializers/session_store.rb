# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pomodo_session',
  :secret      => '81e4fbf8d3e89adf24efdf519b36a4faf6fb6dba36a4863c5999eaf9d13db0ee78cbcd99c65655ec2ebd5514982926df5c82242493b8a4293fea259ca0864c51'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store