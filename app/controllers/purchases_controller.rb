class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :check_item_status, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @purchase_form = PurchaseForm.new
  end

  def create
    Rails.logger.debug "params: #{params.inspect}"

    @purchase_form = PurchaseForm.new(purchase_params)
    if @purchase_form.valid?
      Rails.logger.debug 'PurchaseForm is valid'

      pay_item # 支払い処理を別メソッドに切り出す

      @purchase_form.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      Rails.logger.debug "Errors: #{@purchase_form.errors.full_messages.join(', ')}"
      render :index, status: :unprocessable_entity
    end
  end

  private

  def check_item_status
    # 出品者が商品購入ページを表示しないためのチェック
    redirect_to root_path and return if current_user.id == @item.user_id
    # 売却済みの商品購入ページを表示しないためのチェック
    return unless @item.purchase.present?

    redirect_to root_path and return
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.require(:purchase_form).permit(:post_code, :prefecture_id, :municipality, :house_number, :building, :phone, :price).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 環境変数に置き換えることを推奨
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: purchase_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end
end
