class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_item, only: [:show]

  def index
    @items = Item.includes(image_attachment: :blob).order(created_at: :desc)
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.includes(image_attachment: :blob).find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :image, :title, :description, :category_id, :condition_id,
      :delivery_fee_id, :prefecture_id, :scheduled_delivery_id, :price
    )
  end
end