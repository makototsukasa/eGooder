class PostsController < ApplicationController
  before_action :check_not_login
  before_action :check_post_user, {only: [:edit, :update, :destroy]}

  def index
    @posts = Post.all.order(created_at: "DESC")
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
    if !@user
      @user = User.new()
    end
  end

  def new
    @post = Post.new()
  end

  def create
    @post = Post.new(
        content: params[:content],
        user_id: @current_user.id
      )
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("/posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("/posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post.destroy
      flash[:notice] = "投稿を削除しました"
    else
      flash[:notice] = "投稿を削除できませんでした"
    end
    redirect_to("/posts/index")
  end

  # before_action
  def check_post_user
    @post = Post.find_by(id: params[:id])
    if @current_user.id != @post.user_id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
end
