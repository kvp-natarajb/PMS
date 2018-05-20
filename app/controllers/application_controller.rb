class ApplicationController < ActionController::Base
  require 'will_paginate/array'
  layout :layout_by_resource
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
	  flash[:warning] = exception.message
	  redirect_to root_path
  end

  private

  def layout_by_resource
    if devise_controller?
      "application"
    else
      "dashboard"
    end
  end
end
