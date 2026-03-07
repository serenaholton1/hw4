class EntriesController < ApplicationController

  def new
    if @current_user == nil
      flash["notice"] = "Please log in."
      redirect_to "/login"
      return
    end
  end

  def create
    if @current_user == nil
      flash["notice"] = "Please log in."
      redirect_to "/login"
      return
    end

    @entry = Entry.new
    @entry["title"] = params["title"]
    @entry["description"] = params["description"]
    @entry["occurred_on"] = params["occurred_on"]
    @entry["place_id"] = params["place_id"]
    @entry["user_id"] = @current_user["id"]
    @entry.save
    redirect_to "/places/#{@entry["place_id"]}"
  end

end
