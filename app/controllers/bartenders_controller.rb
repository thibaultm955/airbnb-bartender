class BartendersController < ApplicationController
  require "open-uri"
  def index
    @bartenders = Bartender.all
    @users = User.all

    @markers = @users.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { user: user }),
        #image_url: helpers.asset_url('/images/cocktail2.jpeg')
      }
    end

  end

  def show
    @bartender = Bartender.find(params[:id])
    @user = User.find(@bartender.user_id)

    @reviews = @bartender.reviews
    sum_rating = 0.00
    @reviews.each{ |review| sum_rating += review.rating }
    @reviews.length == 0 ? @average_rating = 0.00 : @average_rating = sum_rating / @reviews.length

  end


  def new
    @bartender = Bartender.new
    @user = User.find(params[:user_id])
  end

  def create
    upload_picture = Cloudinary::Uploader.upload(params[:bartender][:photo].tempfile.path)
    picture_url = upload_picture["url"]
    picture = URI.open(picture_url)
  	@bartender = Bartender.new(:price_per_day => params[:bartender][:price_per_day], :specialty => params[:specialty][0].split, :description => params[:bartender][:price_per_day])
    @user = User.find(params[:user_id])
    @bartender.user = @user
    @bartender.photo.attach(io: picture, filename: "bartender_#{@bartender.user_id}.png", content_type: "image/png")
  	if @bartender.save
  	  redirect_to bartender_path(@bartender)
  	else
  		render :new
    end
  end

  private


  def bartender_params
  
  end

end
