class HomeController < ApplicationController
  def index
    if !user_signed_in?
      render layout: "marketing"
    end
  end
end
