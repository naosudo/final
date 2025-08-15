class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :redirect_unless_owner, only: [:edit, :update] 
  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    
  end


  def update
    if @item.update(item_params)
      redirect_to item_path(@item), notice: "商品情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    if current_user == @item.user
      @item.destroy
      redirect_to root_path, notice: "商品を削除しました"
    else
      redirect_to root_path, alert: "削除権限がありません"
    end
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def redirect_unless_owner
    redirect_to root_path unless current_user == @item.user
  end

  def item_params
    params.require(:item).permit(
      :name,
      :image,
      :price,
      :description,
      :category_id,
      :status_id,
      :payment_id,
      :prefecture_id,
      :day_id
    ).merge(user_id: current_user.id)
  end
end
