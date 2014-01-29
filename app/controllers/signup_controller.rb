class SignupController < ApplicationController

  def signup
      @user = User.new     

  end

   def create
    	@user = User.new(params[:signup])
    	if @user.save
    		flash[:notice] = "You Signed up successfully"
        	flash[:color]= "valid"
      else
        flash[:notice] = "Form is invalid"
        flash[:color]= "invalid"
      end
      render "signup"
    end
end
