class AddFavoriteColorToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :favorite_color, :string
  end
end
