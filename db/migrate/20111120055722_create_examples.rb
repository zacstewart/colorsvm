class CreateExamples < ActiveRecord::Migration
  def change
    create_table :examples do |t|
      t.integer :birth_year
      t.integer :birth_month
      t.integer :birth_day
      t.integer :birth_dow
      t.integer :favorite_season
      t.float :latitude
      t.float :miles_from_major_city
      t.float :time_outdoors
      t.integer :gender
      t.integer :preferred_pattern
      t.integer :likes_spicy_food
      t.integer :dominant_hand
      t.integer :prefers_baths
      t.integer :preferred_pet
      t.integer :night_or_day

      t.timestamps
    end
  end
end
