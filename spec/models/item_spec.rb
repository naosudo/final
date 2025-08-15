require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image.attach(
      io: StringIO.new('fake image content'),
      filename: 'test_image.jpg',
      content_type: 'image/jpeg'
    )
  end

  describe '商品出品' do
    context '商品出品がうまくいくとき' do
      it 'name, image, price, user, description, category_id, status_id, payment_id, prefecture_id, day_idが存在していれば保存できること' do
        expect(@item).to be_valid
      end
    end

    context '商品出品がうまくいかないとき' do
      it 'nameが空では保存できないこと' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'imageが空では保存できないこと' do
        @item.image.detach
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'descriptionが空では保存できないこと' do
        @item.description = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'category_idが空では保存できないこと' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it 'status_idが空では保存できないこと' do
        @item.status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end

      it 'payment_idが空では保存できないこと' do
        @item.payment_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Payment can't be blank")
      end

      it 'prefecture_idが空では保存できないこと' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'day_idが空では保存できないこと' do
        @item.day_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Day can't be blank")
      end

      it 'priceが空では保存できないこと' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが299以下では保存できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it 'priceが10000000以上では保存できないこと' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it 'priceが半角数字でない場合は保存できないこと' do
        @item.price = '１０００' # 全角数字
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it 'category_idの値が0の時は保存できないこと' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 0')
      end

      it 'status_idの値が0の時は保存できないこと' do
        @item.status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Status must be other than 0')
      end

      it 'payment_idの値が0の時は保存できないこと' do
        @item.payment_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Payment must be other than 0')
      end

      it 'prefecture_idの値が0の時は保存できないこと' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 0')
      end

      it 'day_idの値が0の時は保存できないこと' do
        @item.day_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Day must be other than 0')
      end
    end
  end
end
