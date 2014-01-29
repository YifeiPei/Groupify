class ClassController < ApplicationController
  def index

  end

  def add_course
    
  end

  def new

  end

  def create
    @course = Course.new(params[:course])
    if @course.save
      flash[:notice] = "Yay! The course saved."
      flash[:color] = "valid"
    else
       flash[:notice] = "Not saved."
       flash[:color] = "invalid"
    end
  end
end
