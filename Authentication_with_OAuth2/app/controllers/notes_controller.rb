class NotesController < ApplicationController
  def create
    puts("HEY BITCH FUCK U")
    puts(params[:data_value])
    Note.where( uid: current_user.uid ).destroy_all
    Note.create(note_params)
    render :nothing => true
  end
end

def note_params
  JSON.parse(params[:data_value])
end