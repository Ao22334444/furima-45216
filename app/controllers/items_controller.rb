class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item,          only: [:show, :edit, :update, :destroy]
  before_action :authorize_owner!,  only: [:edit, :update, :destroy]

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

  def edit

  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def set_item
    @item = Item.includes(image_attachment: :blob).find(params[:id])
  end

  def authorize_owner!
    redirect_to root_path unless current_user.id == @item.user_id
  end

  def item_params
    params.require(:item).permit(
      :image, :title, :description, :category_id, :condition_id,
      :delivery_fee_id, :prefecture_id, :scheduled_delivery_id, :price
    )
  end
end