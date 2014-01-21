class HomesController < ApplicationController
  # GET /homes
  # GET /homes.json
  def index
    @home = Home.new
  end

 # GET /welcomes/1
  # GET /welcomes/1.json
  def show
	redirect_to root_path
  end
  
  # POST /homes
  # POST /homes.json
  def create
    @home = Home.new(home_params)

    respond_to do |format|
      if @home.save
        format.html { redirect_to @home, notice: 'Email was successfully added.' }
        format.json { render action: 'index', status: :created, location: @home }
      else
        format.html { render action: 'index' }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      @home = Home.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_params
      params.require(:home).permit(:email)
    end
end
