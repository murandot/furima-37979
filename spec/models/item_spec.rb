require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品機能' do
    context '出品できる場合' do
      it '全ての情報が入力されているため出品できる' do
        expect(@item).to be_valid
      end
    end
    context '出品できない場合' do
      it 'imageが選択されていないため出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameが選択されていないため出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'nameが41字以上のため出品できない' do
        @item.name = Faker::Lorem.characters(41)
        @item.valid?
        expect(@item.errors.full_messages).to include('Name is too long (maximum is 40 characters)')
      end
      it 'contentが選択されていないため出品できない' do
        @item.content = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Content can't be blank")
      end
      it 'contentが1000字以上のため出品できない' do   # 100文字
        @item.content = '5y8jvmshibgska8itso0i2h7q8ml68iax4zzllwb6me18b2w4m71w7v184s99gryiw8xwt1jt55jejjuwlusncgo5shhiv3lbdku4ty48a5a1e2xiuwq8nirfzasdzmk6i0xwf6qrnowt9po72p4qh6rbhlnh77vh1p6mp1kp71qb778ydl7ys130yge5xbu6cg38duung9uu78xtyjq40vjxwjbk5isibmwiqreeh13iqjmb9s028eyxao3whprceytxe91py9qqn5o4p87kq2l1bcqrxu0l249caen4efzd0agobb7c0pwzsmzczcbl6nt3m80z62q0racutn5od8cq79bbaarfp438arhq7cwwqtvimb3t49bl9whwmvhath4p5ik43vmc6x7l8mov68jdm3tkbrn045k4vm7feogouvidgevy76cvtlaejsrt9ga7iqgym0bdbrkaf5m4n0hm3bam1hzim4d63c7f71mj7m4iddbhw8m7rmwkrdnbwfmcgdfnlpehsi0n4f4ca1jnzc0uu8esufdfhhv7k8jhhi40h5b5lrkx0j8tjzzifwaakabfu1ola0itfbu7fhncur7ce2zh80tme7m7dymppf137v05wb1su9zbmd70rjwe5frdfufd64dw9axfjqfor6e6mfr4xgcdg63q20x5rjvdot2fi3pxfzr3b9oxguj5zgt1dj7jifhdsnaofkttr0yqevvirpgc8z20voevwiini1ekvug49mtbieylkv6nbnzajyehm8utun46phje9amqx8lgrljvigm3h58ur6f0z9g4tbio9i316xfev33s5kenfbsuygn79maruft45kjfebml6yba4ubdwvbqtpvebtrg72xl4ccetjddgamykit527bbpysi5ttdsdp4b02d2t3ljk5pe67qfl21tq7ocn8cxgtrq21irjmxp78gvrz60q8pa6ibbboxm25zivs62670djnk1qq0'
        @item.valid?
        expect(@item.errors.full_messages).to include('Content is too long (maximum is 1000 characters)')
      end
      it 'category_idが選択されていないため出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'status_idが選択されていないため出品できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end
      it 'fee_idが選択されていないため出品できない' do
        @item.fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Fee can't be blank")
      end
      it 'prefecture_idが選択されていないため出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'schedule_idが選択されていないため出品できない' do
        @item.schedule_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Schedule can't be blank")
      end
      it 'priceが空のため出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが300円より小さいため出品できない' do
        @item.price = Faker::Number.between(to: 299)
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be an integer')
      end
      it 'priceが9,999,999円より大きいため出品できない' do
        @item.price = Faker::Number.between(from: 10_000_000)
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be an integer')
      end
      it 'priceが半角数字でないため出品できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'userが紐づいていなければ出品できない' do
        @item.user = nil
        @item.invalid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
