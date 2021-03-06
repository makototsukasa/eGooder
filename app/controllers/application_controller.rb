class ApplicationController < ActionController::Base
    before_action :set_current_user

    def set_current_user
        @current_user = User.find_by(id: session[:user_id])
        if !@current_user && session[:user_id]
            session[:user_id] = nil
            flash[:notice] = "ログインが必要です"
            redirect_to("/login")
        end
    end

    def check_not_login
        if !session[:user_id]
            flash[:notice] = "ログインが必要です"
            redirect_to("/login")
        end
    end

    def check_login
        if session[:user_id]
            flash[:notice] = "すでにログインしています"
            redirect_to("/users/index")
        end
    end

    def check_account
        if @current_user.id != params[:id].to_i
            flash[:notice] = "権限がありません"
            redirect_to("/users/index")
        end
    end
end
