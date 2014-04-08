require 'api_auth'

module Weary
  module Middleware
    class HMACAuth

      def initialize(app, config = {})
        @app = app
        @access_id = config[:access_id]
        @secret_key = config[:secret_key]
      end

      def call(env)
        request = Rack::Request.new(env)
        @app.call signed_env_for_weary(env)
      end

      private

      attr_reader :access_id, :secret_key

      def env_for_signing(env)
        env.dup.tap do |new_env|
          # Weary::Middleware::ContentType is dynamically injected after
          # this middleware is called and since Content-Type is used to
          # sign HMAC signatures, we have to set it before signing it.
          if ['POST', 'PUT'].include? env['REQUEST_METHOD']
            new_env.update 'CONTENT_TYPE' => 'application/x-www-form-urlencoded'
          end
        end
      end

      def signed_request(env)
        Rack::Request.new(env_for_signing(env)).tap do |r|
          ApiAuth.sign! r, access_id, secret_key
        end
      end

      def signed_env_for_weary(env)
        req = signed_request(env)

        env.dup.tap do |e|
          # Weary wants all headers to be in HTTP_[UPCASE] format for Rack env compatibility
          e.update(
            'HTTP_AUTHORIZATION' => req.env['Authorization'],
            'HTTP_DATE' => req.env['DATE']
          )

          if md5 = req.env['Content-MD5']
            e.update 'HTTP_CONTENT_MD5' => md5
          end
        end
      end
    end
  end
end