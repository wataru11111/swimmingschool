class Public::DateController < ApplicationController
  def new
    @date = Transfer.new
  end

  def create
    # 当日の10時までしか登録できない制限
    begin
      transfer_month = params[:transfer][:transfer_month].to_i
      transfer_day = params[:transfer][:transfer_day].to_i
      selected_date = Date.new(Date.today.year, transfer_month, transfer_day)
      
      if selected_date < Date.today || (selected_date == Date.today && Time.now >= Time.parse("10:00"))
        flash[:alert] = "お休み登録がされていないか、日にちが過ぎている又は当日の10時を過ぎているため登録できません。\nお問い合わせしたい方は080-5011-9947までご連絡ください。"
        redirect_to date_index_path
        return
      end
    rescue ArgumentError
      flash[:alert] = "無効な振替日が選択されました。"
      return render :new
    end

    @transfer = Transfer.new(transfer_params)
    
    # お子さんをfirst_nameとlast_nameで検索
    child = current_customer.children.find_by(
      first_name: params[:transfer][:first_name],
      last_name: params[:transfer][:last_name]
    )
    
    if child.present?
      @transfer.child_id = child.id
      @transfer.transfer_time = params[:transfer][:contact_time] # contact_timeをtransfer_timeに設定
      @transfer.transfer_date = selected_date

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
    # 現在の会員の子どもに関連する振替データのみを取得
    @dates = Transfer.joins(:child).where(children: { customer_id: current_customer.id })
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
