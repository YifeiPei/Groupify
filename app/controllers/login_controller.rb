class LoginController < ApplicationController
  skip_before_filter :authenticate_user
  before_filter :save_login_state
  
  def login
  end
    def login_attempt
    authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      #flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.username}"
      user = User.find_by(id: session[:user_id])
      user.last_login = Date.current
      user.save
      redirect_to "/lecturer"
    else
      flash[:notice] = "Invalid Username or Password"
          flash[:color]= "invalid"
      render "login"  
    end
  end

end
