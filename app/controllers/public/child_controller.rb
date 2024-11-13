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
      Rails.logger.error(@child.errors.full_messages) # エラー内容をログに出力
      render :new
    end
  end

  def edit
    @child = current_customer.children.find(params[:id]) # 子供をIDで取得
     puts "契約曜日: #{@child.contact_dey}"
     puts "契約時間: #{@child.contact_time}"
  end

  def update
    @child = current_customer.children.find(params[:id]) # 子供をIDで取得
    if @child.update(child_params)
      redirect_to customers_show_path, notice: "お子さんの情報を更新しました。"
    else
      Rails.logger.error(@child.errors.full_messages) # エラー内容をログに出力
      flash[:alert] = "情報の更新に失敗しました。"
      render :edit
    end
  end

  private

  def child_params
    params.require(:child).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :contact_dey, :level, :contact_time, :telephone_number)
  end
end
