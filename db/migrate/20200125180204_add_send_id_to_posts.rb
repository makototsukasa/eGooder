class AddSendIdToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :send_id, :integer
  end
end
