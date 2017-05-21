class PagesController < ApplicationController
  def index
    if (current_user)
      @onLoadJson = Note.where( uid: current_user.uid )
    end
  end
end