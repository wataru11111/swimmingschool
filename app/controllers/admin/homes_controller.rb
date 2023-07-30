class Admin::HomesController < ApplicationController
  def top
    @offs = Off.page(params[:page])#.reverse_order
    @dates = Transfer.page(params[:page])#.reverse_order
  end
end
