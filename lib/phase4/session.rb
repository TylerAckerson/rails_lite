require 'json'
require 'webrick'
require 'byebug'

module Phase4
  class Session
    def initialize(req)
      @req = req
      @app_cookie = {}

      cookie = @req.cookies.find { |cook| cook.name == "_rails_lite_app" }

      if cookie
        @app_cookie = JSON.parse(cookie.value)
      end
    end

    def [](key)
      @app_cookie[key]
    end

    def []=(key, val)
      @app_cookie[key] = val
    end

    def store_session(res)
      val_json = @app_cookie.to_json
      res.cookies << WEBrick::Cookie.new("_rails_lite_app", val_json)
    end
  end
end
