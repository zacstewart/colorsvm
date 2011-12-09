require 'svm'
class Survey < ActiveRecord::Base
  has_one :example

  after_save :build_example

  SEASONS         = {:spring => 0, :summer => 1, :fall => 2, :winter => 3}.freeze
  GENDER          = {:male => 0, :female => 0}.freeze
  DOMINANT_HAND   = {:left => 0, :right => 0}.freeze
  PREFERRED_PET   = {:cat => 0, :dog => 1}.freeze
  NIGHT_OR_DAY    = {:night => 0, :day => 1}.freeze
  FAVORITE_COLOR  = {
    red:    0,
    yellow: 1,
    green:  2,
    blue:   3,
    purple: 4,
    orange: 5,
    brown:  6,
    black:  7
  }

  def build_example
    Resque.enqueue(ExampleJob, self.id)
  end

  def featureize
    {
      birth_year:        self.birthday.year,
      birth_month:       self.birthday.month,
      birth_day:         self.birthday.day,
      birth_dow:         self.birthday.strftime('%w').to_i,
      favorite_season:   SEASONS[self.favorite_season.to_sym],
      time_outdoors:     self.time_outdoors,
      gender:            GENDER[self.gender.to_sym],
      preferred_pattern: self.preferred_pattern,
      likes_spicy_food:  self.likes_spicy_food ? 1 : 0,
      dominant_hand:     DOMINANT_HAND[self.dominant_hand.to_sym],
      prefers_baths:     self.prefers_baths ? 1 : 0,
      preferred_pet:     PREFERRED_PET[self.preferred_pet.to_sym],
      night_or_day:      NIGHT_OR_DAY[self.night_or_day.to_sym],
      favorite_color:    FAVORITE_COLOR[self.favorite_color.to_sym]
    }
  end

  def prediction
    model = Model.new('tmp/svm_model')
    prediction = model.predict(self.featureize.values)
    (FAVORITE_COLOR.invert)[prediction.to_i]
  end
end
