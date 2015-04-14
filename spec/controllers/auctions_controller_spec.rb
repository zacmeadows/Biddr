require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do

  let(:auction)   { create(:auction) }
  let(:auction_1) { create(:auction) }

  describe "#index" do
    it "assigns auction instance variable to created auctions" do
      auction
      auction_1
      get :index
      expect(assigns(:auctions)).to eq([auction, auction_1])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "#new" do
    it "renders a new template" do
      get :new
      expect(response).to render_template(:new)
    end
    it "assigns a new campaign instance" do
      get :new
      expect(assigns(:auction)).to be_a_new(Auction)
    end
  end

  describe "#create" do
    context "with valid parameters" do
      def valid_request
        post :create, {auction: {
                          title: "valid campaign title",
                          details: "valid details",
                          price: 100,
                          date: (Time.now + 10.days)
                      }}
      end

      it "adds an auction to the database" do
        expect { valid_request }.to change { Auction.count }.by(1)
      end
      it "redirect to auction index page" do
        valid_request
        expect(response).to redirect_to(root_path(Auction.all))
      end
      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context "with invalid parameters" do
      def invalid_request
        post :create, {auction: {
                          details: "valid details",
                          price: 100,
                          date: (Time.now + 10.days)
                      }}
      end
      it "doesn't create a record in the database" do
        expect { invalid_request }.not_to change {Auction.count}
      end
      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end
      it "sets a flash alert message" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#show" do
    it "assigns an auction instance variable with passed id" do
      # auc = FactoryGirl.create(:auction)
      # get :show, id: auc.id
      # expect(assigns(:auction)).to eq(auc)
      get :show, id: auction.id
      expect(assigns(:auction)).to eq(auction)
    end

    it "renders the show template" do
      # auc = FactoryGirl.create(:auction)
      # get :show, id: auc.id
      get :show, id: auction.id
      expect(response).to render_template(:show)
    end
  end

  describe "#edit" do
    it "renders the edit template" do
      get :edit, id: auction.id
      expect(response).to render_template(:edit)
    end
    it "retrieves the auction with passed id and stores it in instance variable" do
      get :edit, id: auction.id
      expect(assigns(:auction)).to eq(auction)
    end
  end

  describe "#update" do
    context "with valid request" do
      before do
        patch :update, id: auction.id, auction: {title: "title"}
      end

      it "redirects to the auction show page" do
        expect(response).to redirect_to(auction_path(auction))
      end
      it "changes the title of the campaign if it's different" do
        expect(auction.reload.title).to eq("title")
      end
      it "sets a notice flash message" do
        expect(flash[:notice]).to be
      end
    end

    context "with invalid params" do
      before { patch :update, id: auction.id, auction: {title: "", price: 1} }

      it "renders the edit page" do
        expect(response).to render_template(:edit)
      end
      it "doesn't change in the the database" do
        expect(auction.reload.price).not_to eq(1)
      end
      it "sets an alert flash message" do
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#destroy" do
    let!(:auction)   { create(:auction) }

    it "deletes the auction from the database" do
      expect { delete :destroy, id: auction.id }.to change { Auction.count }.by(-1)
    end
    it "redirect to the home page" do
      delete :destroy, id: auction.id
      expect(response).to redirect_to root_path
    end
    it "sets a flash message" do
      delete :destroy, id: auction.id
      expect(flash[:notice]).to be
    end
  end

end
