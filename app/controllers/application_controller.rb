class ApplicationController < ActionController::Base
  protect_from_forgery

  def render_flash(key)
    I18n.t(key, :resource_name => I18n.t(resource.model_name))
  end

  # cancan exception handler
  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = I18n.t("unauthorized.default") || exception.default_message
    flash[:error] = exception.message
    redirect_to root_url
  end
end
