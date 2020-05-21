class BookingsController < ApplicationController
  before_action :find_bartender, only: [:new, :create]
  before_action :authenticate_user!
  def index
    if params[:user_id] == nil
      @bookings = Booking.where(:bartender_id => params[:bartender_id])
      @user = Bartender.find(params[:bartender_id]).user
    else
      @bookings = Booking.where(:user_id => params[:user_id])
      @user = User.find(params[:user_id])
    end
  end

  def show
  	@booking = Booking.find(params[:id])
  end

  def new
  	@booking = Booking.new
  end

  def create
    @bookings_bartender = Booking.where(:bartender_id => params[:bartender_id])
    start_date = params[:booking][:start_date]
    start_date = Date.parse(start_date)
    end_date = params[:booking][:end_date]
    end_date = Date.parse(end_date)
    @bookings_bartender.each do |booking|
      b_start_date = booking.start_date
      b_end_date = booking.end_date
      range = b_start_date..b_end_date
      if (range === start_date) || (range === end_date)
        @booking = Booking.new
        @incorrect = "yes"
        render :new
        return
      end
    end
    @booking = @bartender.bookings.new(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to user_bookings_path(current_user)
    else 
      render :new
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
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
