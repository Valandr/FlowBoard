class CreateJoinTableUsersFigures < ActiveRecord::Migration[8.0]
  def change
    create_join_table :users, :figures do |t|
      t.index [:user_id, :figure_id]
      t.index [:figure_id, :user_id]
    end
  end
end
