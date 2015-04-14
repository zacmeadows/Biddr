require 'rails_helper'

RSpec.describe BidsController, type: :controller do

   let(:auction) { create(:auction) }
   let(:bid) { create(:bid, auction: auction) }

  describe "#create" do
    context "valid bid" do
      def valid_bid
        post :create, auction_id: auction.id, bid: {bid_price: 100}
      end

      it "creates the bid in the database" do
        expect{ valid_bid }.to change{ auction.bids.count }.by(1)
      end
      it "redirects to the auction show page" do
        valid_bid
        expect(response).to redirect_to auction_path(auction.id)
      end
      it "sends flash message" do
        valid_bid
        expect(flash[:notice]).to be 
      end
    end

    context "invalid bid" do
      def invalid_bid
        post :create, auction_id: auction.id, bid: {bid_price: "wow"}
      end
      it "doesn't update the database" do
        expect{ invalid_bid }.to_not change{ auction.bids.count }
      end
      it "redirects to auction page" do
        invalid_bid
        expect(response).to redirect_to auction_path(auction.id)
      end
      it "sets a flash message" do
        invalid_bid
        expect(flash[:alert]).to be
      end
    end
  end
  
end