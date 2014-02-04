class SignupController < ApplicationController
  skip_before_filter :authenticate_user

  def signup
      @user = User.new     

  end

   def create
    	@user = User.new(params[:signup])
    	if @user.save
  		 session[:user_id] = @user.id
    		flash[:notice] = "You Signed up successfully"
        	flash[:color]= "valid"
			redirect_to "/lecturer"
      else
        flash[:notice] = "Form is invalid"
        flash[:color]= "invalid"
      render "signup"
      end
    end
end
