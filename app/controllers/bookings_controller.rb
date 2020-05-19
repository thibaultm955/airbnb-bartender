class BookingsController < ApplicationController
  before_action :find_bartender, only: [:new, :create]

  def index
    @bookings = Booking.where(:user_id => params[:user_id])
    @user = User.find(params[:user_id])
  end

  def show
  	@booking = Booking.find(params[:id])
  end

  def new
  	@booking = Booking.new
  end

  def create
  	@booking = @bartender.bookings.new(booking_params)
  	@booking.user = current_user
  	if @booking.save
  	  redirect_to user_bookings_path(current_user)
  	else 
  		render :new
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.delete
    redirect_to user_bookings_path(current_user)
  end

  private

  def booking_params
  	params.require(:booking).permit(:start_date, :end_date)
  end

  def find_bartender
  	@bartender = Bartender.find(params[:bartender_id])
  end

end
