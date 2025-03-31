class ApplicationController < ActionController::Base
  before_action :authorized
  protect_from_forgery with: :null_session
  include Errors::ErrorsHandler
  include AuthenticateHelper


end
