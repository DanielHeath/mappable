# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mappable_session',
  :secret      => '5723f82e4cb989a7dba40e255e1daad80a38c694d18cb8e93b75549b8782bbc1a1b57bd2310b10ef57f09a865837ab354ff70bbcd61e36e696c0b2e19393ad02'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
