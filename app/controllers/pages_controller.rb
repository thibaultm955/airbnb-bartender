class PagesController < ApplicationController
  def home
    bartenders_array = Bartender.all
    @bartenders = []
    bartenders_array.each_with_index do |bartender, index|
      if index < 10
        @bartenders << bartender
      else
      end
    end
    @users = User.all
    @users = User.geocoded
    @markers = @users.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude
      }
    end
  end
end
