class UsersController < ApplicationController
    before_action :check_not_login, {only: [:index, :show, :edit, :update]}
    before_action :check_login, {only: [:new, :create, :loginform, :login]}
    before_action :check_account, {only: [:edit, :update]}

    def index
        @users = User.all.order(created_at: "DESC")
        @posts = Post.all.order(created_at: "DESC")
    end

    def show
        @user = User.find_by(id: params[:id])
        @posts = Post.where(send_id: @user.id).order(created_at: "DESC")
    end

    def new
        @user = User.new(name: params[:name], email: params[:email])
    end

    def create
        @user = User.new(
            name: params[:name],
            email: params[:email],
            password: params[:password],
            image_name: "default_icon.jpg")
        if @user.save
            flash[:notice] = "アカウントを登録しました"
            session[:user_id] = @user.id
            redirect_to("/users/#{@user.id}")
        else
            render("/users/new");
        end
    end

    def edit
        @user = User.find_by(id: params[:id])
    end

    def update
        @user = User.find_by(id: params[:id])
        @user.name = params[:name]
        @user.password = params[:password]
        if params[:image]
            image = params[:image]
            @user.image_name = "#{@user.id}.jpg"
            File.binwrite("public/user_images/#{@user.image_name}", image.read)
        end
        if @user.save
            flash[:notice] = "アカウントを編集しました"
            redirect_to("/users/#{@user.id}")
        else
            render("/users/edit")
        end
    end

    def loginform
    end

    def login
        user = User.find_by(name: params[:name])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:notice] = "ログインしました"
            redirect_to("/users/index")
        else
            @error_message = "ニックネームまたはパスワードが違います"
            @name = params[:name]
            @password = params[:password]
            render("/users/loginform")
        end
    end

    def logout
        session[:user_id] = nil
        flash[:notice] = "ログアウトしました"
        redirect_to("/login")
    end

    def reissueform
    end

    def reissue
        @user = User.find_by(name: params[:name])
        @user.password = params[:password]
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "パスワードを更新しました"
            redirect_to("/users/index")
        else
            redirect_to("/reissue_form")
        end
    end

    def likes
        @user = User.find_by(id: params[:id])
        @likes = Like.where(user_id: @user.id)
    end

    def destroy
        @user = User.find_by(id: params[:id])
        @posts = Post.where(user_id: params[:id]).or(Post.where(send_id: params[:id]))
        @likes = Like.where(user_id: params[:id])
        @user.destroy
        @posts.each do |post|
            post.destroy
        end
        @likes.each do |like|
            like.destroy
        end
        redirect_to("/login")
    end

    def ranking
        @type = params[:type]
        @period = params[:period]
        if @type=="receive"
            case @period
            when "week" then
                to = Time.now
                from = (to - 1.week)
                @posts = Post.where(created_at: from...to)
                @users = User.find(@posts.group(:send_id).order('count(send_id) desc').pluck(:send_id))
            when "month" then
                to = Time.now
                from = (to - 1.month)
                @posts = Post.where(created_at: from...to)
                @users = User.find(@posts.group(:send_id).order('count(send_id) desc').pluck(:send_id))
            when "year" then
                to = Time.now
                from = (to - 1.year)
                @posts = Post.where(created_at: from...to)
                @users = User.find(@posts.group(:send_id).order('count(send_id) desc').pluck(:send_id))
            else
                @users = User.find(Post.group(:send_id).order('count(send_id) desc').pluck(:send_id))
                @posts = Post.all
            end
        else
            case @period
            when "week" then
                to = Time.now
                from = (to - 1.week)
                @posts = Post.where(created_at: from...to)
                @users = User.find(@posts.group(:user_id).order('count(user_id) desc').pluck(:user_id))
            when "month" then
                to = Time.now
                from = (to - 1.month)
                @posts = Post.where(created_at: from...to)
                @users = User.find(@posts.group(:user_id).order('count(user_id) desc').pluck(:user_id))
            when "year" then
                to = Time.now
                from = (to - 1.year)
                @posts = Post.where(created_at: from...to)
                @users = User.find(@posts.group(:user_id).order('count(user_id) desc').pluck(:user_id))
            else
                @users = User.find(Post.group(:user_id).order('count(user_id) desc').pluck(:user_id))
                @posts = Post.all
            end
        end
    end
end
