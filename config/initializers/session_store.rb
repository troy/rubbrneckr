# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sirenspotter_session',
  :secret      => '4c1a7a8024b44c424b87cfb23a12d636f3021ec147562e376b6cef936b382635cf244de41ebc75b0baf115af0d2477bed85c1543e5feb48c9a7bbc40bb7b3c07'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
