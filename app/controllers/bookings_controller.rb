class BookingsController < ApplicationController
  before_action :find_bartender, only: [:new, :create]
  before_action :authenticate_user!
  def index
    if params[:user_id] == nil
      @bookings = Booking.order('end_date DESC').where(:bartender_id => params[:bartender_id])
      @bookings_unordered = Booking.order('end_date ASC').where(:bartender_id => params[:bartender_id])
      @user = Bartender.find(params[:bartender_id]).user
      @bartender_true = "yes"
    else
      @bookings = Booking.order('end_date DESC').where(:user_id => params[:user_id])
      @bookings_unordered = Booking.order('end_date ASC').where(:user_id => params[:user_id])
      @user = User.find(params[:user_id])
    end
    respond_to do |format|
      format.html
      format.json { render json: {bookings: @bookings } }
    end
    
    @sum_cost = 0
    @bookings_sum = []
    @bookings_unordered.each do |booking|
      @number_of_day_booking = (booking.end_date - booking.start_date).to_i + 1
      @cost_booking = booking.bartender.price_per_day * @number_of_day_booking
      @bookings_sum << [booking.end_date, @cost_booking]
      @sum_cost += @cost_booking
      
    end
    @bookings_sum_per_month = {}
    @bookings_sum.each do |booking|
      if @bookings_sum_per_month[(booking[0].month)] != nil
        @bookings_sum_per_month[booking[0].month] += booking[1]
      else
        @bookings_sum_per_month[booking[0].month] = booking[1]
      end
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
      range_booking = start_date..end_date
      if (range === start_date) || (range === end_date) || (range_booking === range)
        @booking = Booking.new
        @incorrect = "yes"
        render :new
        return
      end
    end
    @booking = @bartender.bookings.new(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to user_bookings_path(current_user), info: "your Bartender : #{@bartender.user.last_name}, from #{@booking.start_date} to #{@booking.end_date}."
    else 
      render :new
    end
  end

  def edit
    @booking = Booking.find(params[:id])
    @bartender = @booking.bartender
    @user = @booking.user
  end

  def update
    @booking = Booking.find(params[:id])
    @bartender = @booking.bartender
    @user = @booking.user
    if @booking.update(booking_params)
      redirect_to user_bookings_path(@user), notice: 'your booking was successfully updated.'
    else
      render :edit
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
