class AboutController < ApplicationController
  skip_before_filter :authenticate_user
  def index
    
  end

  def blog
    
  end

  def privacy

  end

  def export_privacy
    send_file "#{Rails.root}/public/GroupifyPrivacyPolicy.v01.pdf" 
  end

end
