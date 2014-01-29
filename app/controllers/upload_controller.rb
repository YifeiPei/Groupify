class UploadController < ApplicationController

  def upload_file
    if params[:file]
      directory = 'uploads'
      path = File.join(directory, params[:file].original_filename)
      if File.file?(path)
        flash[:notice] = 'This file has already been uploaded. Please rename'
      else
        File.open(path, "wb") {|f| f.write(params[:file].read) }
        flash[:notice] = 'You uploaded ' + params[:file].original_filename
      end
    else
      flash[:notice] = 'You did not give me anything'
    end  
    render 'index'
  end
end
