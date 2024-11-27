class Admin::OffsController < ApplicationController
  def index
    if params[:search_date].present?
      search_date = Date.parse(params[:search_date])
      @offs = Off.where(off_month: search_date)
    else
      @offs = Off.all
    end
  end
end