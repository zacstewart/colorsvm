class Example < ActiveRecord::Base
  belongs_to :survey

  def label
    favorite_color
  end

  def features
    [
      birth_year,
      birth_month,
      birth_day,
      birth_dow,
      favorite_season,
      # latitude,
      # miles_from_major_city,
      time_outdoors,
      gender,
      preferred_pattern,
      likes_spicy_food,
      dominant_hand,
      prefers_baths,
      preferred_pet,
      night_or_day
    ]
  end
end
