class Public::DateController < ApplicationController
  def new
    @date = Transfer.new
  end

  def create
    @transfer = Transfer.new(transfer_params)
    child = current_customer.child.find_by(first_name: params[:transfer][:child_first_nama])
    # @date.customer_id = current_customer.id
    @transfer.child_id = child.id
    off = child.offs.where(flag: 0).last
    @transfer.off_id = off.id
    if @transfer.save!
      off.update(flag: 1)
      redirect_to dates_completion_path(id: @transfer.id)
    else
      render :index
    end
  end

  def index
    @date = Transfer.new
  end


  def confirmation
     #@dates = Transfer.find(params[:id])
    @dates = Transfer.all
  end

  def completion
    @dates = Transfer.find(params[:id])
    #@dates = Transfer.all
  end

  def show

  end
end

private
 def transfer_params
    params.require(:transfer).permit(:level, :transfer_date, :transfer_time, :telephone_number)
 end
