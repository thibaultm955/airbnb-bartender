class PagesController < ApplicationController
  def home
    bartenders_array = Bartender.all
    @bartenders = []
    bartenders_array.each_with_index do |bartender, index|
      if index < 6
        @bartenders << bartender
      end
    end
  end
end
