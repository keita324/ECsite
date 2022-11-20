class Admin::OrderDetailsController < ApplicationController
  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    flag = 0
    flag2 = 0
    # order_detailの中身を調べてる
    order_detail.order.order_details.each do |order_detail|
      if order_detail.product_status == "making"
        flag = 1
      end
      
      if order_detail.product_status != "finish"
        flag2 = 1
      end
    end
    
    if flag == 1
      order_detail.order.update(order_status: "making")
    end
    
    if flag2 == 0
      order_detail.order.update(order_status: "before_sending")
    end
   
    redirect_to admin_order_path(order_detail.order_id)
    
  end
  
      
  def order_detail_params
      params.require(:order_detail).permit(:product_status)
  end
end
