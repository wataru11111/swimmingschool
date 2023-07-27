class Public::CustomersController < ApplicationController
  def show
    @child = Child.new
  end

  def edit
     @customer = current_customer
  end

  def update
     @cart_item = current_customer
    @cart_item.update(customer_params)
    redirect_to customers_show_path
  end
end


 def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number)
 end