class LandingsController < ApplicationController
  skip_before_filter :authenticate_user
 
  # GET /landings
  # GET /landings.json
  def index
      session[:err_msg] = []
    @landing = Landing.new
  end
  
  def feedback
  end
  
  def Thankyou
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_landing
      @landing = Landing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def landing_params
      params.require(:landing).permit(:email)
    end
end
