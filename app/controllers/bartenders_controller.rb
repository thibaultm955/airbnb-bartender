class BartendersController < ApplicationController

  def index
    @bartenders = Bartender.all
    @users = User.all
  end

  def show
    @bartender = Bartender.find(params[:id])
    @user = User.find(@bartender.user_id)
  end

  private

end
