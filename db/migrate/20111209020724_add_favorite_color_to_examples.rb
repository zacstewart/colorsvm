class AddFavoriteColorToExamples < ActiveRecord::Migration
  def change
    add_column :examples, :favorite_color, :integer
  end
end
