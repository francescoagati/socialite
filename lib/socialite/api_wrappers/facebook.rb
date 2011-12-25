module Socialite
  module ApiWrappers
    module Facebook
      extend ActiveSupport::Concern

      included do
        require 'koala'
      end

      module ClassMethods
        def lookup(unique_id, options={})
          options.reverse_merge!({:access_token => nil})
          api_connection(options[:access_token]).get_object(unique_id)
        end

        def api_connection(access_token=nil)
          Koala::Facebook::API.new(access_token)
        end
      end

      module InstanceMethods
        def account_url
          "http://facebook.com/#{login}"
        end

        def access_token
          raise unless super
        end

        def api
          api_connection
        end

        def checkins
          api.get_connections(unique_id, 'checkins')
        end

        def friends
          api.get_connections(unique_id, 'friends')
        end

        def login
          raise unless super
        end

        def picture
          api.get_picture(unique_id)
        end

        def info
          api.get_object(unique_id)
        end

        def unique_id
          raise unless super
        end

        def method_missing(meth, *args, &block)
          if @target.respond_to?(meth)
            self.class.class_eval <<-end_eval
              def #{meth}(*args, &block)
                @target.__send__(:#{meth}, *args, &block)
              end
            end_eval
            __send__(meth, *args, &block)
          else
            super # NoMethodError
          end
        end

      protected

        def api_connection
          @api_connection ||= self.class.api_connection(access_token)
        end
      end
    end
  end
end

