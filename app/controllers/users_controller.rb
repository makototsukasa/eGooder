class UsersController < ApplicationController
    before_action :check_not_login, {only: [:index, :show, :edit, :update]}
    before_action :check_login, {only: [:new, :create, :login_form, :login]}
    before_action :check_account, {only: [:edit, :update]}

    def index
        @users = User.all.order(created_at: "DESC")
    end

    def show
        @user = User.find_by(id: params[:id])
        @posts = Post.where(user_id: @user.id).order(created_at: "DESC")
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

    def login_form
    end

    def login
        user = User.find_by(name: params[:name])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:notice] = "ログインしました"
            redirect_to("/posts/index")
        else
            @error_message = "ニックネームまたはパスワードが違います"
            @name = params[:name]
            @password = params[:password]
            render("/users/login_form")
        end
    end

    def logout
        session[:user_id] = nil
        flash[:notice] = "ログアウトしました"
        redirect_to("/login")
    end

    def likes
        @user = User.find_by(id: params[:id])
        @likes = Like.where(user_id: @user.id)
    end
end
