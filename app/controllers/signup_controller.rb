class SignupController < ApplicationController

  def signup
      @user = User.new     

  end

   def create
    	@user = User.new(params[:signup])
    	if @user.save
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
