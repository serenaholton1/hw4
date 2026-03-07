class EntriesController < ApplicationController

  def new
    if @current_user == nil
      flash["notice"] = "Please log in."
      redirect_to "/login"
      return
    end

    @place = Place.find_by({
      "id" => params["place_id"],
      "user_id" => @current_user["id"]
    })
    if @place == nil
      flash["notice"] = "Place not found."
      redirect_to "/places"
    end
  end

  def create
    if @current_user == nil
      flash["notice"] = "Please log in."
      redirect_to "/login"
      return
    end

    @place = Place.find_by({
      "id" => params["place_id"],
      "user_id" => @current_user["id"]
    })
    if @place == nil
      flash["notice"] = "Place not found."
      redirect_to "/places"
      return
    end

    @entry = Entry.new
    @entry["title"] = params["title"]
    @entry["description"] = params["description"]
    @entry["occurred_on"] = params["occurred_on"]
    @entry["place_id"] = @place["id"]
    @entry["user_id"] = @current_user["id"]
    @entry.save
    if params["image"] != nil
      @entry.image.attach(params["image"])
    end
    redirect_to "/places/#{@entry["place_id"]}"
  end

end
