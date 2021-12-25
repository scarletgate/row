class NotificationsController < ApplicationController
  def index
    # current_userの投稿に関連した通知一覧
    @notifications = current_user.passive_notifications.page(params[:page]).per(10).where(checked: false).reverse_order
  end

  # 通知の全削除
  def destroy_all
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
