# Add this to config/initaializers/swfupload_session_hack.rb

# Based on the code from http://seventytwo.co.uk/posts/making-swfupload-and-rails-work-together

# The following code is a work-around for the Flash 8 bug that prevents our multiple file uploader
# from sending the _session_id.  Here, we hack the Session#initialize method and force the session_id
# to load from the query string via the request uri. (Tested on Lighttpd, Mongrel, Apache)
class CGI::Session
  alias original_initialize initialize

  def initialize(request, option = {})
    option = scan_for_session_id(request, '_swfupload_session_id', option) unless option['session_id']
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