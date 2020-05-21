class BartendersController < ApplicationController

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


end
