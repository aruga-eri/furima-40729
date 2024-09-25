class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update]
  # before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to root_path, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
        # format.turbo_stream { redirect_to @item }
      end
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    if current_user.id != @item.user_id || @item.purchase.blank?
    else
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    # return unless @item.destroy

    # redirect_to root_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:image, :name, :explanation, :category_id, :situation_id, :load_id, :prefecture_id,
                                 :delivery_id, :price).merge(user_id: current_user.id)
  end
end

def check_user
  return if current_user.id == @item.user_id

  redirect_to root_path, alert: '他のユーザーの情報を編集することはできません。'
end
