
class ItemsController < ApplicationController
  protect_from_forgery 
  def index
    @women_items = Item.with_attached_images.order("id DESC").limit(4)
    @men_items = Item.with_attached_images.order("id DESC").limit(4)
    @child_items = Item.with_attached_images.order("id DESC").limit(4)
    @chanel_items = Item.with_attached_images.order("id DESC").limit(4)
    @vuitton_items = Item.with_attached_images.order("id DESC").limit(4)
    @nike_items = Item.with_attached_images.order("id DESC").limit(4)
    
  end

  def new
    @item = Item.new
    @delivary = Delivary.new
  end

  def create
    @item = Item.new(item_params)
    @delivary = Delivary.new(delivary_params)
    if @item.save && @delivary.save
      redirect_to item_path(@item)
    else
      render :new
    end
  end
  
  def show
    @item = Item.with_attached_images.find(params[:id])
    @user = Item.find(params[:id]).seller
    @user_item = Item.with_attached_images.where(seller_id: @user.id).order("id DESC").limit(6)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def item_params
    params.require(:item).permit(:name, :text, :category_id, :brand_id, :status, images: []).merge(params.require(:item).require(:item).permit(:price)).merge(seller_id: current_user.id)
  end

  def delivary_params
    params.require(:item).require(:delivary).permit(:price, :area, :delivary_day)
  end
end
