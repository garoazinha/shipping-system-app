class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def check_user_role
    if current_user.standard?
       return redirect_to root_path, alert: 'Apenas usuários administradores têm acesso a essa ação'
    end
  end

end
