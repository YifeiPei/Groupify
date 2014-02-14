class UploadController < ApplicationController
  def index
  end
  def import
  Student.import(params[:file],session[:course_id])
	redirect_to "/lecturer"
end

  def upload_file
    if params[:file]
      @upload = Upload.new
      @upload.add_file(params[:file])
  
      @upload.username = 'bob'
      if @upload.save
        flash[:notice] = 'You uploaded ' + params[:file].original_filename #+ @upload.file_id
		@file = Upload.find_by_id(@upload.id)
        Course.where(:id => session[:course_id]).update_all(filelocation: "#{@file.file_id}")
      else
        flash[:notice] = "An error occured"
      end
    else
      flash[:notice] = 'You did not give me anything'
    end  
    render 'index'
  end
end
