class TrainsController < ApplicationController
    before_action :admin_authorized, only: [:new, :create, :edit, :update, :destroy]

    def index
        @trains = Train.where('departure_date >= ?', Date.today)
                .where('seats_left > ?', 0)
                .order(departure_date: :asc, departure_time: :asc)
        @rating_filter = params[:rating]
        if @rating_filter.present?
            @trains = @trains.where("average_rating >= ?", @rating_filter)
        end

        @departure_station = params[:departure_station]
        @termination_station = params[:termination_station]
  
        if @departure_station.present?
            @trains = @trains.where("LOWER(departure_station) LIKE ?", "%#{@departure_station.downcase}%")
        end
      
        if @termination_station.present?
            @trains = @trains.where("LOWER(termination_station) LIKE ?", "%#{@termination_station.downcase}%")
        end
    end

    def new
        @train = Train.new
    end
    
    def create
        @train = Train.new(train_params)
    
        if @train.save
          flash[:success] = 'Trained Created Sucessfully!'
          redirect_to trains_path
        else
          render :new, status: :unprocessable_entity
        end
    end

    def edit
        @train = Train.find(params[:id])
    end

    def update
        @train = Train.find(params[:id])
        if @train.update(train_params)
          flash[:success] = 'Train was successfully updated.'
          redirect_to trains_path
        else
          render :edit
        end
    end

    def get_highly_rated_trains
        @trains = Train.where('average_rating > ?', 3)
        render action: "index"
    end

    def book
        @train = Train.find(params[:id])
        @booking = Booking.new(train: @train, user: current_user)
        @booking.price = @train.ticket_price
        if @booking.save
          @train.decrement!(:seats_left)
          flash[:success] = "Booking successful! Your booking code is: #{@booking.booking_code} and price is #{@booking.price}. Go to View bookings section at home page to view all your bookings !"
        else
            flash[:failure] = 'Unfortunately your booking was not successful!'
        end
        redirect_to trains_path
    end
    
    def cancel_booking
        @train = Train.find(params[:id])
        @booking = current_user.bookings.find_by(train: @train)
    
        if @booking.destroy
          @train.increment!(:seats_left)
          flash[:success] = 'Booking successfully cancelled!'
        else
          flash[:success] = 'Booking failed to cancel! Please contact customer care!'
        end
        redirect_to trains_path
    end

    def show
        @train = Train.find(params[:id])
        @has_reviews = @train.reviews.any?
        @review = @train.reviews.find_by(user_id: current_user.id)
    end

    def destroy
        @train = Train.find(params[:id])
        @train.destroy
        flash[:success] = 'Train SUccessfully Deleted'
        respond_to do |format|
          format.html { redirect_to trains_url}
          format.json { head :no_content }
        end
    end

    private

    def train_params
      params.require(:train).permit(
        :number,
        :departure_station,
        :termination_station,
        :departure_date,
        :departure_time,
        :arrival_date,
        :arrival_time,
        :ticket_price,
        :train_capacity,
        :seats_left,
        :average_rating
      )
    end

    private

    def admin_authorized
      redirect_to root_path unless logged_in? && current_user.admin?
    end

end
