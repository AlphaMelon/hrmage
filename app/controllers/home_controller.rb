class HomeController < ApplicationController
  def index
    if !account_signed_in?
      render layout: "marketing"
    end
  end
end
