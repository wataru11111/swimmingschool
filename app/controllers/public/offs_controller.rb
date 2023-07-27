class Public::OffsController < ApplicationController

 def new
    @offs = Off.new
    @offs = Off.all
 end

 def create
  @offs = Off.new(off_params)
  @offs.customer_id = current_customer.id
  if @child.save
    redirect_to new_off_path
  else
    render :new
  end
 end

  def index

  end
end


private
 def off_params
    params.require(:off).permit(:off_day)
 end
