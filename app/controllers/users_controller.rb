class UsersController < ApplicationController

  def tweets
    @user = User.find(params[:id])
    @tweets = Tweet.where(user_id: @user).order(created_at: :desc)
    @user.likes_count = @user.likes.size

  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:notice] = "Profile Updated"
      redirect_to tweets_user_path
    else
      flash[:notice] = @user.errors.full_messages
    end
  end

  def followings
    @user = User.find(params[:id])
    @tweets = Tweet.where(user_id: @user)
    @followings = @user.followings.order(created_at: :desc)# 基於測試規格，必須講定變數名稱
  end

  def followers
    @user = User.find(params[:id])
    @tweets = Tweet.where(user_id: @user)
    @followers = @user.followers.order(created_at: :desc) # 基於測試規格，必須講定變數名稱
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.liked_tweets.all # 基於測試規格，必須講定變數名稱
    @tweets = Tweet.where(user_id: @user)
    @user.likes_count = @user.likes.size
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end
