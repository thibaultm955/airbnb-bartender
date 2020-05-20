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

    @markers = @bartenders.map do |bart|
      {
        lat: bart.user.latitude,
        lgn: bart.user.longitude
      }
    end


  end
end
