class AddCategoryToFigures < ActiveRecord::Migration[8.0]
  def change
    add_column :figures, :category, :string, array: true, default: []
  end
end
