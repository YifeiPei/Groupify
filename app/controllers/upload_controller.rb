class UploadController < ApplicationController
  def index
  end
def file_upload
    tmp = params[:file_upload][:my_file].tempfile
    require 'ftools'
    file = File.join("public", params[:file_upload][:my_file].original_filename)
    FileUtils.cp tmp.path, file
end
end