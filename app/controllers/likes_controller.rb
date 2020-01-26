class LikesController < ApplicationController
    before_action :check_not_login

    def create
        @like = Like.new(
            user_id: @current_user.id,
            post_id: params[:post_id].to_i
        )
        @like.save
        redirect_to("/posts/#{params[:post_id]}")
    end

    def destroy
        @like = Like.find_by(
            user_id: @current_user.id,
            post_id: params[:post_id].to_i
        )
        @like.destroy
        redirect_to("/posts/#{params[:post_id]}")
    end
end
