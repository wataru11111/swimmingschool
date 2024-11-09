class Public::DateController < ApplicationController
  def new
    @date = Transfer.new
  end

  def create
    @transfer = Transfer.new(transfer_params)
    
    # お子さんをfirst_nameとlast_nameで検索
    child = current_customer.child.find_by(
      first_name: params[:transfer][:first_name],
      last_name: params[:transfer][:last_name]
    )
    
    if child.present?
      @transfer.child_id = child.id
      @transfer.transfer_time = params[:transfer][:contact_time] # contact_timeをtransfer_timeに設定

      # 振替月と振替日から振替日付を作成
      begin
        transfer_month = params[:transfer][:transfer_month].to_i
        transfer_day = params[:transfer][:transfer_day].to_i
        @transfer.transfer_date = Date.new(Date.today.year, transfer_month, transfer_day)
      rescue ArgumentError
        flash[:alert] = "無効な振替日が選択されました。"
        return render :new
      end

      # お休みデータを取得してflagを更新
      off = child.offs.where(flag: 0).last
      if off.present?
        @transfer.off_id = off.id
        if @transfer.save!
          off.update(flag: 1)
          redirect_to dates_completion_path(id: @transfer.id)
        else
          render :index
        end
      else
        flash[:alert] = "対象のお休みが見つかりませんでした。"
        render :new
      end
    else
      flash[:alert] = "指定されたお子さんが見つかりませんでした。"
      render :new
    end
  end

  def index
    @date = Transfer.new
  end

  def confirmation
    @dates = Transfer.all
  end

  def completion
    @dates = Transfer.find(params[:id])
  end

  def show
  end

  private
  
  def transfer_params
    params.require(:transfer).permit(:level, :transfer_time, :telephone_number, :transfer_month, :transfer_day, :contact_dey)
  end  
end
