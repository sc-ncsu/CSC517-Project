class ReviewsController < ApplicationController
    before_action :set_train, only: [:create, :edit, :update]
    before_action :set_review, only: [:edit, :update]

    def index
      @reviews = Review.all
    end

    def new
      @train = Train.find(params[:train_id])
      @review = Review.new
    end

    def search
      @reviews = Review.all
      filter_reviews(params[:user_q], params[:train_q])
      render :index
    end
  
    def create
      @review = current_user.reviews.new(review_params)
      @review.train = @train
  
      if @review.save
        update_train_rating
        flash[:success] = "Review was successfully created."
        redirect_to @train
      else
        render 'trains/show'
      end
    end
  
    def edit
      @train = Train.find(params[:train_id])
      @review = Review.find(params[:id])
      unless @review.user == current_user
        redirect_to @train, alert: 'You cannot edit reviews written by other users.'
      end
    end
  
    def update
      if @review.user == current_user
        if @review.update(review_params)
          update_train_rating
          redirect_to @train, notice: 'Review was successfully updated.'
        else
          render :edit
        end
      else
        redirect_to @train, alert: 'You cannot edit reviews written by other users.'
      end
    end
  
    private
  
    def set_train
      @train = Train.find(params[:train_id])
    end
  
    def set_review
      @review = @train.reviews.find(params[:id])
    end
  
    def review_params
      params.require(:review).permit(:feedback, :rating)
    end

    def update_train_rating
      average_rating = @train.reviews.average(:rating)
      @train.update(average_rating: average_rating)
    end

    def filter_reviews(user_query, train_query)
      @reviews = @reviews.joins(:user, :train)
      @reviews = @reviews.where("lower(users.name) LIKE ?", "%#{user_query.downcase}%") if user_query.present?
      @reviews = @reviews.where("lower(trains.number) LIKE ?", "%#{train_query.downcase}%") if train_query.present?
    end
  end
  