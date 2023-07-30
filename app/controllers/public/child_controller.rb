class Public::ChildController < ApplicationController
  def new
    @child = Child.new
  end

  def create
    @child = Child.new(child_params)
    @child.customer_id = current_customer.id
    if @child.save
      redirect_to customers_show_path
    else
      render :new
    end
  end

  def edit
    @child = current_customer.child
  end

  def update
    child = current_customer.child
    @child = child
    @child.update(child_params)
    redirect_to customers_show_path
  end


  def child_params
    params.require(:child).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :contact_dey, :level, :contact_time, :telephone_number)
  end
end
