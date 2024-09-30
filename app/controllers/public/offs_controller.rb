class Public::OffsController < ApplicationController

 def new
    @off = Off.find(params[:id])
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
 
     if @off.save
       redirect_to new_off_path(id: @off.id), notice: "お休みが登録されました"
     else
       render :new
     end
   else
     flash[:alert] = "該当するお子さんが見つかりませんでした。"
     render :new
   end
 end

  def index
     @offs = Off.new
  end

end
 def off_params
    params.require(:off).permit(:off_day, :child_id, :level, :flag, :contact_time, :contact_dey)
 end
