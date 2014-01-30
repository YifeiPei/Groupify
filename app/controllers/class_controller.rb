class ClassController < ApplicationController
  def index

  end

  def add_course
    
  end

  def new

  end

  def create
    @course = Course.new do |c|
      c.name = params[:course][:name]
      c.user_id = session[:user_id]
    end
    if @course.save
      flash[:notice] = "Course added."
      flash[:color] = "valid"
    else
       flash[:notice] = "Course not added."
       flash[:color] = "invalid"
    end
  end
end
