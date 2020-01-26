class Post < ApplicationRecord
    validates :content, {presence: true, length: {maximum: 140}}
    validates :user_id, {presence: true}
    validates :send_id, {presence: true}

    def user
        user = User.find_by(id: self.user_id)
        if !user
            user = User.new()
        end
        return user
    end
end
