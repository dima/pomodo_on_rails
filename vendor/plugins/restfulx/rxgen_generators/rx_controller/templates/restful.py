# The MIT License
# 
# Copyright (c) 2008 William T. Katz
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to 
# deal in the Software without restriction, including without limitation 
# the rights to use, copy, modify, merge, publish, distribute, sublicense, 
# and/or sell copies of the Software, and to permit persons to whom the 
# Software is furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
# DEALINGS IN THE SOFTWARE.
 
"""
RESTful Controller
 
We want our RESTful controllers to simply throw up their hands if they get
an unhandled HTTP verb.  This is better for rich clients and server load
than throwing back lots of useless HTML.
 
These inherited methods should be overridden if there's a chance a human
browser is involved.
 
TODO: Return more information HTTP status codes that won't autotrip 
browser login forms.  For example, return status 405 (Method not allowed) 
with an Allow header containing the list of valid methods.
"""
__author__ = 'William T. Katz'
 
from google.appengine.ext import webapp
 
import logging
 
# Some useful module methods
def send_successful_response(handler, response):
    logging.debug("Sending successful response: %s", response)
    handler.response.headers["Content-Type"] = "application/xml"
    handler.response.out.write('<?xml version="1.0" encoding="UTF-8"?>')
    handler.response.out.write(response)
    
def get_model_key(handler):
  return handler.request.path_info.split("/").pop().replace(".xml", "")
 
def get_sent_properties(request_func, propname_list):
    """
    This maps request strings to values in a hash, optionally run through 
    a function with previous request values as parameters to the func.
    1) key -> just read in the corresponding request value
    2) tuple (key, func) -> Read the request value for the string key
        and pass it through func
    3) tuple (key, func, additional keys...) -> Get the request
        values for the additional keys and pass them through func
        before setting the key's value with the output.
    If a key is not present in the request, then we do not insert a key
    with None or empty string.  The key is simply absent, therefore allowing
    you to use the returned hash to initial a Model instance.
    """
    prop_hash = {}
    for item in propname_list:
        if isinstance(item, basestring):
            key = item
            value = request_func(item)
        elif isinstance(item, tuple):
            key = item[0]
            prop_func = item[1]
            if len(item) <= 2:
                value = prop_func(request_func(key))
            else:
                try:
                    addl_keys = map(prop_hash.get, item[2:])
                    value = prop_func(*addl_keys)
                except:
                    return None
        if value:
            prop_hash[key] = value
    return prop_hash
 
def methods_via_query_allowed(handler_method):
    """
    A decorator to automatically re-route overloaded POSTs
    that specify the real HTTP method in a _method query string.
 
    To use it, decorate your post method like this:
 
    import restful
    ...
    @restful.methods_via_query_allowed
    def post(self):
      pass
 
    The decorator will check for a _method query string or POST argument,
    and if present, will redirect to delete(), put(), etc.
    """
    def redirect_if_needed(self, *args, **kwargs):
        real_verb = self.request.get('_method', None)
        if not real_verb and 'X-HTTP-Method-Override' in self.request.environ:
            real_verb = self.request.environ['X-HTTP-Method-Override']
        if real_verb:
            logging.debug("Redirected from POST. Detected method override = %s", real_verb)
            method = real_verb.upper()
            if method == 'HEAD':
                self.head(*args, **kwargs)
            elif method == 'PUT':
                self.put(*args, **kwargs)
            elif method == 'DELETE':
                self.delete(*args, **kwargs)
            elif method == 'TRACE':
                self.trace(*args, **kwargs)
            elif method == 'OPTIONS':
                self.head(*args, **kwargs)
            # POST and GET included for completeness
            elif method == 'POST':
                self.post(*args, **kwargs)
            elif method == 'GET':
                self.get(*args, **kwargs)
            else:
                self.error(405)
        else:
            handler_method(self, *args, **kwargs)
    return redirect_if_needed
 
class Controller(webapp.RequestHandler):
    def get(self, *params):
        self.redirect("/403.html")
 
    def head(self, *params):
        pass