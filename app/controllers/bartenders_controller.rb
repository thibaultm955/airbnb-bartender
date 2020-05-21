class BartendersController < ApplicationController
  require "open-uri"
  def index
    if params[:query].present? && params[:query2].present? && params[:query3].present? && params[:query4].present?
      bartenders = search_bartenders(params[:query], params[:query2])
      search_query_date(params[:query3], params[:query4], bartenders)

    elsif params[:query2].present? && params[:query3].present? && params[:query4].present?
      bartenders = search_bartenders("", params[:query2])
      search_query_date(params[:query3], params[:query4], bartenders)

    elsif params[:query].present? && params[:query3].present? && params[:query4].present?
      bartenders = search_bartenders(params[:query])
      search_query_date(params[:query3], params[:query4], bartenders)

    elsif params[:query].present? && params[:query2].present?
      search_query(params[:query], params[:query2])

    elsif params[:query3].present? && params[:query4].present?
      bartenders = Bartender.all
      search_query_date(params[:query3], params[:query4], bartenders)

    elsif params[:query2].present? && params[:query3].present?
      bartenders = search_bartenders("", params[:query2])
      search_query_date(params[:query3], "", bartenders)

    elsif params[:query3].present?
      search_query_date(params[:query3])

    elsif params[:query4].present?
      search_query_date("", params[:query4])

    elsif  params[:query].present?
      search_query(params[:query])

    elsif params[:query2].present?
      search_query("thibault", params[:query2])

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

  def search_bartenders(query1, query2 = "")
    sql_query = " \
    first_name @@ :query \
    OR last_name @@ :query \
    OR address @@ :query2\
  "
    @bartenders = []
    # sql_query = "first_name ILIKE :query OR last_name ILIKE :query"
    @users = User.where(sql_query, query: "%#{query1}%", query2: "%#{query2}%")
    @users = @users.geocoded
    @bartenders_users = []
    @users.each do |user_i|
      @bartenders << Bartender.where(:user_id => user_i.id)[0]
    end
    return @bartenders
  end

  def search_query(query1, query2 = "")
    sql_query = " \
    first_name @@ :query \
    OR last_name @@ :query \
    OR address @@ :query2\
  "
    @bartenders = []
    # sql_query = "first_name ILIKE :query OR last_name ILIKE :query"
    @users = User.where(sql_query, query: "%#{query1}%", query2: "%#{query2}%")
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
  end


  def search_query_date(query_1, query_2 = "", bartenders)
    @bartenders_available = {}
    @bartenders = bartenders
    @bartenders.each do |bartender|
      @bookings_bartender = Booking.where(:bartender_id => bartender.id)
      if query_1 != "" && query_2 != ""
        start_date = Date.parse(query_1)
        end_date = Date.parse(query_2)
      elsif query_1 != "" && query_2 == ""
        start_date = Date.parse(query_1)
        end_date = Date.parse(query_1)
      else 
        start_date = Date.parse(query_2)
        end_date = Date.parse(query_2)
      end
      @bartenders_available[bartender.id] = "yes"
      @bookings_bartender.each do |booking|
        b_start_date = booking.start_date
        b_end_date = booking.end_date
        range = b_start_date..b_end_date
        range_booking = start_date..end_date
        @available = "yes"
          if (range === start_date) || (range === end_date) || (range_booking === range)
            @bartenders_available[bartender.id] = "no"
          end
      end
    end
    @bartenders = []
    @bartenders_users = []
    @bartenders_available.each do |bartender_id, available|
      if available == "yes"
        @bartenders << Bartender.find(bartender_id)
      end
    end
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

  private


  def bartender_params
  
  end

end
