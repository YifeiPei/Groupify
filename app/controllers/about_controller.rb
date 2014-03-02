class AboutController < ApplicationController
  skip_before_filter :authenticate_user
  def index
    
  end

  def blog
    
  end

  def privacy

  end

  def export_privacy
  	render "/about/privacy"
    #send_data csv_string, :type => "text/csv; charset=iso-8859-1; header=present", :disposition => "attachment; filename=GroupifyPrivacyPolicy.pdf"
  end

end
