class BartendersController < ApplicationController
  require "open-uri"

  before_action :set_bartender, only: [ :edit, :update]
  def index
    if params[:query].present?
      @bartenders = []
      sql_query = "first_name ILIKE :query OR last_name ILIKE :query"
      @users = User.where(sql_query, query: "%#{params[:query]}%")
      @users = @users.geocoded
      @bartenders_users = []
      @users.each do |user_i|
        @bartenders << Bartender.where(:user_id => user_i.id)[0]
        @bartenders_users << Bartender.where(:user_id => user_i.id)[0].user
      end
      @markers = @bartenders_users.map do |user|
        {
          lat: user.latitude,
          lng: user.longitude,
          infoWindow: render_to_string(partial: "info_window", locals: { user: user }),
          image_url: helpers.asset_url('cocktail.png')
        }
      end
    else
      @bartenders = Bartender.all
      @users = User.all
      @users = User.geocoded
      @bartenders_users = []
      @bartenders.each do |bartender|
        @bartenders_users << bartender.user 
      end
      @markers = @bartenders_users.map do |user|
        {
          lat: user.latitude,
          lng: user.longitude,
          infoWindow: render_to_string(partial: "info_window", locals: { user: user }),
          image_url: helpers.asset_url('cocktail.png')
        }
      end
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
  	@bartender = Bartender.new(:price_per_day => params[:bartender][:price_per_day], :specialty => params[:specialty][0].split, :description => params[:bartender][:description])
    @user = User.find(params[:user_id])
    @bartender.user = @user
    @bartender.photo.attach(io: picture, filename: "bartender_#{@bartender.user_id}.png", content_type: "image/png")
  	if @bartender.save
  	  redirect_to bartender_path(@bartender)
  	else
  		render :new
    end
  end

  def edit
  end

  def update
    @user = @bartender.user
    @bartender.update(:price_per_day => params[:bartender][:price_per_day], :specialty => params[:specialty][0].split, :description => params[:bartender][:description])
    redirect_to user_path(@user)
  end

  private

  def set_bartender
    @bartender = Bartender.find(params[:id])
  end

end
