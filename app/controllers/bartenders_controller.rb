class BartendersController < ApplicationController
  before_action :set_bartender, only: [:show, :edit, :update, :destroy]

  def index
  	@bartenders = Bartender.all
  end

  def show
  end

  def new
  	@user = User.find(params[:user_id])
  	@bartender = Bartender.new
  end

  def create
  	@user = User.find(params[:user_id])
  	@bartender = Bartender.new(bartender_params)
  	@bartender.user = @user

  	if @bartender.save
  	  redirect_to bartender_path(@bartender)
  	else 
  		render :new
    end
  end

  def edit
  end

  def update
  	@bartender.update(bartender_params)
  	redirect_to bartender_path(@bartender)
  end

  def destroy
  	@bartender.destroy
  	redirect_to bartenders_path
  end

  private

  def bartender_params
  	params.require(:bartender).permit(:price_per_day)
  end

  def set_bartender
  	@bartender = Bartender.find(params[:id])
  end
end
