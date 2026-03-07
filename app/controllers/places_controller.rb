class PlacesController < ApplicationController
  before_action :require_login

  def require_login
    if @current_user == nil
      flash["notice"] = "Please log in."
      redirect_to "/login"
    end
  end

  def index
    @places = Place.where({ "user_id" => @current_user["id"] })
  end

  def show
    @place = Place.find_by({
      "id" => params["id"],
      "user_id" => @current_user["id"]
    })

    if @place == nil
      flash["notice"] = "Place not found."
      redirect_to "/places"
      return
    end

    @entries = Entry.where({
      "place_id" => @place["id"],
      "user_id" => @current_user["id"]
    }).order({ "occurred_on" => :desc, "created_at" => :desc })
  end

  def new
  end

  def create
    @place = Place.new
    @place["name"] = params["name"]
    @place["user_id"] = @current_user["id"]
    @place.save
    redirect_to "/places"
  end

end
