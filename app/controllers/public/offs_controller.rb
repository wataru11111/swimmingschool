module Public
  class OffsController < ApplicationController
    def new
      @off = Off.find_by(id: params[:off_id]) || Off.new
    end

    def create
      begin
        # フォームから送られる off_month を使用して日付を作成
        off_date = Date.new(
          params[:off]["off_month(1i)"].to_i,
          params[:off]["off_month(2i)"].to_i,
          params[:off]["off_month(3i)"].to_i
        )
      rescue ArgumentError => e
        flash[:alert] = "無効な日付が選択されました: #{e.message}"
        redirect_to new_off_path and return
      end
    
      # 過去の日付や当日の10時以降は登録不可
      if off_date < Date.today || (off_date == Date.today && Time.now >= Time.parse("10:00"))
        flash[:alert] = "日にちが過ぎている又は当日の10時を過ぎているため登録できません。\nお問い合わせしたい方は080-5011-9947までご連絡ください。"
        redirect_to offs_path and return
      end
    
      # 新しい Off オブジェクトを作成
      @off = Off.new(off_params)
      @off.off_month = off_date # off_month に Date 型の日付を設定
    
      # 子供データを検索
      child = current_customer.children.find_by(
        first_name: params[:off][:child_first_name],
        last_name: params[:off][:child_last_name]
      )
    
      if child
        # 子供データが見つかった場合、必要な情報を設定
        @off.child_id = child.id
        @off.level = child.level
        @off.flag = 0
        @off.contact_time = child.contact_time
        @off.contact_dey = child.contact_dey
        @off.last_name = child.last_name # NOT NULL制約を満たすため
        @off.first_name = child.first_name # NOT NULL制約を満たすため
    
        # Off データの保存処理
        if @off.save
          flash[:notice] = 'お休みが登録されました。'
          redirect_to new_off_path(off_id: @off.id)
        else
          flash.now[:alert] = @off.errors.full_messages.join(", ")
          render :index
        end
      else
        flash.now[:alert] = "該当するお子さんが見つかりませんでした。"
        render :index
      end
    end
    

    def index
      @offs = Off.all
    end

    def show_absences
      @child = Child.find(params[:id])
      @offs = Off.where(child_id: @child.id).order(created_at: :desc)
    end

    def edit_absence
      @off = Off.find(params[:id])
      @off_date = @off.off_month # すでにdate型なので直接取得
    end

    def update_absence
      @off = Off.find(params[:id])
    
      begin
        # ユーザーが入力した日付をdate型として取得
        selected_date = Date.parse(params[:off][:off_month])
      rescue ArgumentError
        flash[:alert] = "無効な日付が選択されました。"
        render :edit_absence and return
      end
    
      # 過去の日付に変更するのを防ぐ
      if selected_date < Date.today
        flash[:alert] = "過去の日付には変更できません。"
        render :edit_absence and return
      end
    
      # `off_month`を更新
      if @off.update(off_month: selected_date)
        flash[:notice] = "お休み情報を更新しました。"
        redirect_to show_absences_off_path(id: @off.child_id)
      else
        flash[:alert] = "お休み情報の更新に失敗しました。"
        render :edit_absence
      end
    end

    def destroy
      @off = Off.find(params[:id])
      @off.destroy
      redirect_to show_absences_off_path(id: @off.child_id), notice: 'お休みがキャンセルされました'
    end

    private

    def off_params
      params.require(:off).permit(:off_day, :off_month, :child_id, :level, :flag, :contact_time, :contact_dey)
    end
  end
end
