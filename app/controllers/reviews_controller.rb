class ReviewsController < ApplicationController
  before_action :set_review, only: %i[new create]
  def new
    # @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    # @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new(review_params)
    @review.restaurant = @restaurant
    # @review.save
    # redirect_to restaurant_path(@restaurant)

    if @review.save
      redirect_to restaurant_path(@restaurant)
    else
      render 'restaurants/show', status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to restaurant_path(@review.restaurant), status: :see_other
  end

  private

  def set_review
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
