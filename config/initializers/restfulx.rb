# the following patches allow us to overwrite session key on file uploads from Flash, 
# which ends up creating a new session for every File.upload() invocation.

require 'rack/utils'

class FlashSessionCookieMiddleware
  def initialize(app, session_key = '_session_id')
    @app = app
    @session_key = session_key
    @session_token = "_session_id"
  end

  def call(env)
    if env['HTTP_USER_AGENT'] =~ /^(Adobe|Shockwave) Flash/
      params = ::Rack::Utils.parse_query(env['QUERY_STRING'])
      env['HTTP_COOKIE'] = [ @session_key, params[@session_token] ].join('=').freeze unless params[@session_token].nil?
    end
    @app.call(env)
  end
end

# If you have configured your Rails/Flex/AIR application to share authenticity_token
# comment this out to enable forgery protection. By default, this is disabled to allow
# generated code to work out of the box.
ActionController::Base.allow_forgery_protection = true