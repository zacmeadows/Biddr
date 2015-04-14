class AuctionsController < ApplicationController

  before_action :find_auction, only: [:show, :edit, :update, :destroy]

  def index 
    @auction = Auction.new 
    @auctions = Auction.all
  end 

  def new
    @auction = Auction.new
  end 

  def create 
    @auction = Auction.new auction_params
    @auction.current_bid = 0
    if @auction.save
      redirect_to root_path, notice: "Auction created successfully"
    else
      flash[:alert] = "Auction Not Created!"
      render :new
    end 
  end

  def show
    @bid = @auction.bids.new
    @bids = Bid.all
  end  

  def edit
  end 

  def update
    if @auction.update auction_params
      redirect_to auction_path, notice: "Auction Updated!"
    else
      flash[:alert] = "Auction didn't update"
      render :edit
    end
  end

  def destroy
    @auction.destroy
    redirect_to root_path, notice: "Auction deleted!"
  end 


  private

  def find_auction
    @auction = Auction.find params[:id] 
  end 

  def auction_params
    params.require(:auction).permit(:title, :details, 
                                      :price, :date)
  end

end
