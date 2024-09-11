class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
    redirect_to '/'
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :explanation, :category_id, :situation_id, :load_id, :prefecture_id,
                                 :delivery_id, :price).merge(user: current_user.id)
  end
end
