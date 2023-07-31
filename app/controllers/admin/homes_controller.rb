class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @offs = Off.page(params[:page])#.reverse_order
    @dates = Transfer.page(params[:page])#.reverse_order
  end
end
