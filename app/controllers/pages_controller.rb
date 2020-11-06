class PagesController < ApplicationController
  def about

  end

  def home
    redirect_to articles_path if logged_in?
  end
end
