class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest

      t.integer :level, default: 0
      t.integer :session_duration, default: 0
      t.string :jti, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
