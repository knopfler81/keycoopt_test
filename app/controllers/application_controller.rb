class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :http_basic_authenticate

   def http_basic_authenticate
    authenticate_or_request_with_http_basic do |name, password|
      name == 'facturation@keycoopt.com' && password == 'password'
    end
  end
end



