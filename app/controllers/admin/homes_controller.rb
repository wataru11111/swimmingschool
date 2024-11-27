class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    if params[:search_date].present?
      search_date = Date.parse(params[:search_date])
      @dates = Transfer.where(transfer_date: search_date)
    else
      @dates = Transfer.all
    end

    @offs = Off.all # お休み情報の取得は変更なし
  end
end
