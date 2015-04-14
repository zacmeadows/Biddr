class BidsController < ApplicationController

  def create 
    @auction = Auction.find params[:auction_id]
    @bid = @auction.bids.new bid_params
    if @bid.bid_price > @auction.current_bid
      if @bid.save
        redirect_to @auction
        @auction.current_bid = @bid.bid_price
        @auction.save
      else
        redirect_to @auction, notice: "Failed"
      end 
    else
      flash[:alert] = "Bid must be bigger"
      redirect_to @auction
    end 
  end 

  private

  def bid_params
    params.require(:bid).permit(:bid_price)
  end 

end
