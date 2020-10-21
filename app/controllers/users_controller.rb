class UsersController < ApplicationController
  
  # def new
  #   @image = Image.new
  # end

  def show
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:email, :name, images: [])
    end
end