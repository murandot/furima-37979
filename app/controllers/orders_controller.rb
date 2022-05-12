class OrdersController < ApplicationController

  def index
    set_item
    if current_user == @item.user || Order.exists?(item_id: @item.id)
      redirect_to root_path
    elsif current_user !=  @item.user && !Order.exists?(item_id: @item.id)
      @order_address = OrderAddress.new
    else
      redirect_to new_user_session_path
    end
  end
  
  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      set_item
      render :index
    end
  end
  
  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
  
  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: Item.find(order_params[:item_id]).price,
        card: order_params[:token],
        currency: 'jpy'
      )
  end

end

