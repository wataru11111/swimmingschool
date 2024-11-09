# app/controllers/public/offs_controller.rb
module Public
  class OffsController < ApplicationController

    def new
      @off = Off.new
    end

    def create
      @off = Off.new(off_params)
      child = current_customer.children.find_by("first_name = ? AND last_name = ?", params[:off][:child_first_name], params[:off][:child_last_name])
    
      if child
        @off.child_id = child.id
        @off.level = child.level
        @off.flag = 0
        @off.contact_time = child.contact_time
        @off.contact_dey = child.contact_dey
        @off.last_name = params[:off][:child_last_name]
        @off.first_name = params[:off][:child_first_name]
    
        # `off_month`と`off_day`をセット
        @off.off_month = params[:off][:off_month].to_i
        @off.off_day = params[:off][:off_day].to_i
    
        if @off.save
          render :new
        else
          render :new
        end
      else
        flash[:alert] = "該当するお子さんが見つかりませんでした。"
        render :new
      end
    end
    
    

    def index
      @offs = Off.all
    end

    # お休み確認ページ
    def show_absences
      @child = Child.find(params[:id])           # 特定の子供の情報を取得
      @offs = Off.where(child_id: @child.id)           # 子供のお休み情報を取得
    end

    # お休み変更ページ
    def edit_absence
      @off = Off.find(params[:id]) 
       # `off_month`と`off_day`を使って、仮の日付（今年の年で設定）を設定
  @off_date = Date.new(Date.today.year, @off.off_month, @off.off_day)                 # 特定のお休みを取得
    end

    def destroy
      @off = Off.find(params[:id])
      @off.destroy
      redirect_to show_absences_off_path(id: @off.child_id), notice: 'お休みがキャンセルされました'
    end

    # お休み変更の更新アクション
    def update_absence
      @off = Off.find(params[:id])
    
      # 選択された日付が今日以降であることを確認
      selected_date = Date.new(Date.today.year, params[:off][:off_month].to_i, params[:off][:off_day].to_i)
      
      if selected_date < Date.today
        flash[:alert] = "過去の日付には変更できません。"
        render :edit_absence
      elsif @off.update(off_params)
        redirect_to show_absences_off_path(id: @off.child_id), notice: 'お休みの変更が完了しました'
      else
        render :edit_absence
      end
    end

    private

    def off_params
      params.require(:off).permit(:off_day, :off_month, :child_id, :level, :flag, :contact_time, :contact_dey)
    end
  end
end
