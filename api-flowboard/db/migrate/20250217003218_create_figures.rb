class CreateFigures < ActiveRecord::Migration[8.0]
  def change
    create_table :figures do |t|
      t.string :name
      t.text :description
      t.string :skill_level
      t.integer :duration
      t.string :video_url

      t.timestamps
    end
  end
end
