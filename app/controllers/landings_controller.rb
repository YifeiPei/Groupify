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


  # GET /landings/1
  # GET /landings/1.json
  def show
	redirect_to root_path
  end

  # POST /landings
  # POST /landings.json
  def create
    @landing = Landing.new(landing_params)
    respond_to do |format|
      if @landing.save
        format.html { redirect_to @landing }
        format.json { render action: 'index', status: :created, location: @landing }
      else
        format.html { render action: 'index' }
        format.json { render json: @landing.errors, status: :unprocessable_entity }
      end
    end
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
