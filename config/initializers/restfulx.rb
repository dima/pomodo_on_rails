# When you do file uploads from Flash with File.upload() that, unfortunately generates a new session id,
# which will fail to authenticate if you are using restful-authentication plugin or equivalent.
#
# The following code is a work-around for the Flash bug that prevents file uploader
# from sending correct session_id. Here, we hack the Session#initialize method and force the session_id
# to load from the query string via the request URI.
#
# Based on the code from http://seventytwo.co.uk/posts/making-swfupload-and-rails-work-together
begin
  require 'rack/utils'

  class FlashSessionCookieMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      if env['HTTP_USER_AGENT'] =~ /^(Adobe|Shockwave) Flash/
        @session_key = ActionController::Base.session_options[:session_key]
        params = ::Rack::Utils.parse_query(env['QUERY_STRING'])
        env['HTTP_COOKIE'] = [ @session_key, params[@session_key] ].join('=').freeze unless params[@session_key].nil?
      end
      @app.call(env)
    end
  end

  ActionController::Dispatcher.middleware.use FlashSessionCookieMiddleware
rescue LoadError
  class CGI::Session
    alias original_initialize initialize

    def initialize(request, option = {})
      option = scan_for_session_id(request, '_session_id', option) unless option['session_id']
      original_initialize(request, option)
    end

    def scan_for_session_id(request, session_key = '_session_id', option = {})
      query_string = if (qs = request.env_table["QUERY_STRING"]) and qs != ""
        qs
      elsif (ru = request.env_table["REQUEST_URI"][0..-1]).include?("?")
        ru[(ru.index("?") + 1)..-1]
      end
      if query_string and query_string.include?(session_key)
        option['session_id'] = query_string.scan(/#{session_key}=(.*?)(&.*?)*$/).flatten.first
      end
      return option
    end
  end
end

# If you have configured your Rails/Flex/AIR application to share authenticity_token
# comment this out to enable forgery protection. By default, this is disabled to allow
# generated code to work out of the box.
ActionController::Base.allow_forgery_protection = true