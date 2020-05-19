class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def index
  	@reviews = Review.all
  end

  def show
  end

  def new
  	@@bartender = Bartender.find(params[:bartender_id])
  	@review = Review.new
  end

  def create
  	@review = Review.new(review_params)
  	@user = User.find(params[:user_id])
  	@bartender = Bartender.find(params[:bartender_id])
  	@review.bartender = @bartender
  	@review.user = @user

  	if @review.save
  	  redirect_to review_path(@review)
  	else 
  		render :new
    end
  end

  def edit
  end

  def update
  	@review.update(review_params)
  	redirect_to review_path(@review)
  end

  def destroy
  	@review.destroy
  	redirect_to reviews_path
  end

  private

  def review_params
  	params.require(:review).permit(:rating, :comment)
  end

  def set_review
  	@review = Review.find(params[:id])
  end
end