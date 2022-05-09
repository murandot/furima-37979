class ItemsController < ApplicationController
  def index
<<<<<<< HEAD
    @items = Item.all.order('created_at DESC')
=======
>>>>>>> parent of ac41279 (商品の新着順表示機能の実装)
  end

  def new
    if user_signed_in?
      @item = Item.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :content, :category_id, :status_id, :fee_id, :prefecture_id,
                                 :schedule_id, :price).merge(user_id: current_user.id)
  end
end
