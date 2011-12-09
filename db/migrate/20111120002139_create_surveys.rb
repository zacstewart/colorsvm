class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.date :birthday
      t.string :favorite_season
      t.string :hometown
      t.integer :time_outdoors
      t.string :gender
      t.integer :preferred_pattern
      t.boolean :likes_spicy_food
      t.string :dominant_hand
      t.boolean :prefers_baths
      t.string :preferred_pet
      t.string :night_or_day

      t.timestamps
    end
  end
end
