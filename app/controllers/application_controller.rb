class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protect_from_forgery

  def authorize
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end

  # before_action :check_owner, only: [ :edit, :update, :destroy ]
  before_action :require_login

  # def check_owner
  #   redirect_to(root_url, alert: "You can only edit your own posts") unless @post.author == current_user
  # end

  # private
  # def current_user
  #  @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end
  # helper_method :current_user

  helper_method :current_user

  private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # def require_login
  #  unless current_user
  #    redirect_to login_path, alert: "Please log in"
  #  end
  # end

  def require_login
    unless current_user || login_page?
      redirect_to login_path, alert: "Please log in"
    end
  end

  def login_page?
    controller_name == "sessions" && (action_name == "new" || action_name == "create")
  end
end
