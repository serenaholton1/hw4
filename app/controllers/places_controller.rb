class PlacesController < ApplicationController
  before_action :require_login

  def require_login
    if @current_user == nil
      flash["notice"] = "Please log in."
      redirect_to "/login"
    end
  end

  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })
    if @current_user == nil
      @entries = Entry.none
    else
      @entries = Entry.where({
        "place_id" => @place["id"],
        "user_id" => @current_user["id"]
      }).order({ "occurred_on" => :desc, "created_at" => :desc })
    end
  end

  def new
  end

  def create
    @place = Place.new
    @place["name"] = params["name"]
    @place.save
    redirect_to "/places"
  end

end
