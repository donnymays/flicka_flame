class ImagesController < ApplicationController
  before_action :only => [:new, :destroy] do
    redirect_to new_user_session_path unless current_user && current_user.admin
    
  end


  def index
      if params[:user_id]
        @user = current_user
        @image = @user.images.new
        @images = Image.all
      else
        # @user = User.find(params[:id])
        @images = Image.all
      end
  end

  def new
    # @user = User.find(params[:user_id])
    @user = current_user
    @image = @user.images.new
    # render: new
  end

  def create
    @user = current_user
    @image = @user.images.new(image_params)
    @image.photo.attach(params[:image][:photo])
    @image.user = current_user
    if @image.save
      flash[:notice] = "Photo uploaded!"
      redirect_to user_image_path(@user, @image)
    else
      flash[:alert] = "Can't upload photo!"
      render :new
    end
  end

  def show
    if params[:id]
      @image = Image.find(params[:id])
      @users = User.all
    end
    if params[:user_id]
      @user = @image.user
    end
  end

  def edit
    @image = Image.find(params[:id])
    if @image.user == current_user
      render :edit
    else
      flash[:alert] = "you aren't authorized to do dat!"
      redirect_to image_path(@image)
    end
  end

  def destroy
  @image = Image.find(params[:id])
    if @image.destroy
      flash[:notice] = "Image deleted"
      redirect_to user_path(@image.user)
    end
  end

  private
    def image_params
      params.require(:image).permit(:title, :user_id, photos: [])
    end
end