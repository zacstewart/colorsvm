class Example < ActiveRecord::Base
  belongs_to :survey

  scope :trainable, where('favorite_color IS NOT NULL')

  def self.all_trainable
    @_all_trainable ||=
      trainable.shuffle
  end

  def self.cv_set
    m = all_trainable.length
    m_cv = (m / 3).floor
    all_trainable[0..m_cv]
  end

  def self.training_set
    all_trainable - cv_set
  end

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
      # Location is probably going to be crap data ultimately.
      # Comment these out until I can cleanly get these params
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
