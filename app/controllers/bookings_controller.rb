class BookingsController < ApplicationController
  before_action :find_bartender, only: [:new, :create, :show]

  def index
  	@bookings = Booking.all
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
  	  redirect_to bartender_bookings_path(@booking)
  	else 
  		render :new
    end
  end


  private

  def booking_params
  	params.require(:booking).permit(:start_date, :end_date)
  end

  def find_bartender
  	@bartender = Bartender.find(params[:bartender_id])
  end

end
