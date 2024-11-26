class OrdersController < ApplicationController
  before_action :set_order, only: [ :show, :edit, :update, :destroy, :checkout_payment ]

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to @order
    else
      render :new, status: :unprocessable_entity
      return
    end
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: "Order was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy!
    redirect_to orders_path, status: :see_other, notice: "Order was successfully destroyed."
  end

  def checkout_payment
    razorpay_order = Razorpay::Order.create(
      amount: (@order.amount * 100).to_i,
      currency: 'INR',
    )

    render json: {
      key: Rails.application.credentials.dig(:razorpay, :key_id),
      order_id: razorpay_order.id,
      amount: razorpay_order.amount,
      currency: razorpay_order.currency,
      name: 'Pankaj Porwal',
      description: 'Payment for Order'
    }
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:amount, :status)
    end
end
