class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :baria_user, only: [:update, :edit]

  def index
  	@user = User.new
  	@users = User.all.order(created_at: :desc)
  end

  def show
  	@user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
      flash[:notice] = "successfully"
  	  redirect_to user_path(@user.id)
    else
      @user = User.find(params[:id])
      flash[:notice] = "error"
      render :edit
    end
  end

  def destroy
  	user = User.find(params[:id])
    user.destroy
    redirect_to users_path
  end

  private

  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def baria_user
    unless params[:id].to_i == current_user.id
        redirect_to user_path(current_user)
    end
  end

end
