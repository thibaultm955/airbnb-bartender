  class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users= User.all
    #@users = User.geocoded # returns users with coordinates

    #@markers = @users.map do |user|
      #{
       # lat: user.latitude,
       # lng: user.longitude,
      #}
    #end

  end

  def edit
  end

  def update
  	@user.update(user_params)
  	redirect_to user_path(@user)
  end

  def destroy
  	@user.destroy
  	redirect_to users_path
  end

  def show
    @bartenders = Bartender.all
    @bartenders.each do |b|
      if b.user_id == current_user.id
        @bartender = b
      else
        @bartender = "you're not a bartender"
      end
    end  
  end

  private

  def user_params
  	params.require(:user).permit(:email, :encrypted_password, :first_name, :last_name, :email_address, :address)
  end

  def set_user
  	@user = User.find(params[:id])
  end
end
