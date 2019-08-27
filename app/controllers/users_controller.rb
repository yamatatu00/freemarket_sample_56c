class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :card_add_to]
  before_action :set_header
  before_action :set_item, only: [:show, :listing, :trading, :completed, :purchase, :purchased, :things]
  before_action :set_card, only: [:card_add_to]

  def show
  end

  def user_card
    gon.payjp_key = ENV["PAYJP_KEY"]
  end

  def card_add_to
  end

  def things
  end

  def listing
  end

  def trading
  end

  def completed
  end

  def purchase
  end

  def purchased
  end

  def item_message
    @item = Item.with_attached_images.find(params[:id])
    @comments = @item.comments.includes(:user)
    # @delivary = Delivary.find_by(item_id:params[:id])
    # @item_buyer = Item.with_attached_images.find_by(buyer_id: @item.id).find_by(seller_id: @item.id)
  end

  private

  def set_item
    @item_seller = Item.with_attached_images.where(seller_id: current_user.id).where(buyer_id: nil).order("id DESC").limit(10)
    @item_buyer = Item.with_attached_images.where(buyer_id: current_user.id).order("id DESC").limit(5)
    @item_trading =  Item.with_attached_images.where(seller_id: current_user.id).where("buyer_id > ?", 1).order("id DESC").limit(10)
    @user = User.all
    @hash = @item_trading.map{|hash| hash[:buyer_id] + 1}
  end

  def set_card
    @card = Card.where(params[:user_id])
  end
end
