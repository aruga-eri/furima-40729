require 'rails_helper'

RSpec.describe PurchaseForm, type: :model do
  before do
    @purchase_form = FactoryBot.build(:purchase_form)
  end

  describe '配送先情報の保存' do
    context '配送先情報の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_form).to be_valid
      end
      it 'user_idが空でなければ保存できる' do
        @purchase_form.user_id = 1
        expect(@purchase_form).to be_valid
      end
      it 'item_idが空でなければ保存できる' do
        @purchase_form.item_id = 1
        expect(@purchase_form).to be_valid
      end
      it '郵便番号が「3桁＋ハイフン＋4桁」の組み合わせであれば保存できる' do
        @purchase_form.post_code = '123-4560'
        expect(@purchase_form).to be_valid
      end
      it '都道府県が「---」以外かつ空でなければ保存できる' do
        @purchase_form.prefecture_id = 1
        expect(@purchase_form).to be_valid
      end
      it '市区町村が空でなければ保存できる' do
        @purchase_form.municipality = '横浜市'
        expect(@purchase_form).to be_valid
      end
      it '番地が空でなければ保存できる' do
        @purchase_form.house_number = '青山1-1-1'
        expect(@purchase_form).to be_valid
      end
      it '建物名が空でも保存できる' do
        @purchase_form.building = nil
        expect(@purchase_form).to be_valid
      end
      it '電話番号が11番桁以内かつハイフンなしであれば保存できる' do
        @purchase_form.phone = '12345678910'
        expect(@purchase_form).to be_valid
      end
    end

    context '配送先情報の保存ができないとき' do
      it 'user_idが空だと保存できない' do
        @purchase_form.user_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと保存できない' do
        @purchase_form.item_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Item can't be blank")
      end
      it '郵便番号が空だと保存できないこと' do
        @purchase_form.post_code = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Post code can't be blank",
                                                               'Post code is invalid. Include hyphen(-)')
      end
      it '郵便番号にハイフンがないと保存できないこと' do
        @purchase_form.post_code = '1234567'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it '都道府県が「---」だと保存できないこと' do
        @purchase_form.prefecture_id = 0
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県が空だと保存できないこと' do
        @purchase_form.prefecture_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと保存できないこと' do
        @purchase_form.municipality = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Municipality can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @purchase_form.house_number = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("House number can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @purchase_form.phone = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone can't be blank")
      end
      it '電話番号にハイフンがあると保存できないこと' do
        @purchase_form.phone = '123 - 1234 - 1234'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Phone is invalid')
      end
      it '電話番号が12桁以上あると保存できないこと' do
        @purchase_form.phone = '1234567891012'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Phone is invalid')
      end
      it 'トークンが空だと保存できないこと' do
        @purchase_form.token = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
