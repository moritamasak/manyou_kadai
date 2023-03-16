class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy, :update]
  before_action :require_admin 

  def new
    @user = User.new
  end

  def create
    @user = User.new(admin_user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザーを作成しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(admin_user_params)
      flash[:notice] =  "ユーザーを更新しました"
      redirect_to admin_users_path
    else
      render :edit, notice: "管理者がいなくなります！ #{@user.name} の管理者を外して更新ができません！"
    end
  end
  def show
  end

  def index
    @users = User.all.includes(:tasks).order(created_at: :desc)
  end

  def destroy
    if@user.destroy
      redirect_to admin_users_path, notice: "ユーザーを削除しました"
    else
      redirect_to admin_users_path, notice: "管理者がいなくなり、 削除ができません"
    end
  end

  private

  def admin_user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
    
  end

  def require_admin
    unless current_user.admin?
      redirect_to tasks_path, notice: "あなたは管理者ではありません"
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
