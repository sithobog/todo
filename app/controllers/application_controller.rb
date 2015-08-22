class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  helper_method :owner?, :active?

  def after_sign_in_path_for(resource)
    current_user
  end

  def after_sign_out_path_for(resource_or_scope)
   request.referrer
  end

  def owner?
    @user == current_user
  end

  def active?(object)
    object.status == 'active'
  end

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end

  private

  def my_notice(obj = controller_name)
    notice = obj.capitalize.singularize + " successfully "
    if action_name == "destroy"
      notice+ "deleted."
    else
      notice + action_name + "d."
    end
  end

  def my_alert(obj = controller_name)
    action_name == "destroy" ? action = "delete" : action = action_name
    l = -> (action) { "You do not have permission to " + action + " " + obj.singularize + "." }
    l.call(action)
  end
end
