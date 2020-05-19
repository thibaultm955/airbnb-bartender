class BartendersController < ApplicationController

  def index
  	@bartenders = Bartender.all
  end

  def show
  	@bartender = Bartender.find(params[:id])
  end

  private

end
