require 'svm'
class Survey < ActiveRecord::Base
  has_one :example

  after_create :generate_unique_id!
  after_save :build_example

  validates_presence_of :birthday, :favorite_season, :hometown, :time_outdoors, :gender,
    :preferred_pattern, :likes_spicy_food, :dominant_hand, :prefers_baths, :preferred_pet,
    :night_or_day

  validates_uniqueness_of :unique_id

  SEASONS         = {:spring => 0, :summer => 1, :fall => 2, :winter => 3}.freeze
  GENDER          = {:male => 0, :female => 1}.freeze
  DOMINANT_HAND   = {:left => 0, :right => 1}.freeze
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
    self.example.destroy if self.example.present?
    example_hash = self.featureize
    example_hash.merge!(:favorite_color => self.labelize) if self.favorite_color.present?
    self.example = Example.create(example_hash)
  end

  def featureize
    {
      birth_year:        self.birthday.year,
      birth_month:       self.birthday.month,
      birth_day:         self.birthday.day,
      birth_dow:         self.birthday.strftime('%w').to_i,
      favorite_season:   SEASONS[self.favorite_season.downcase.to_sym],
      time_outdoors:     self.time_outdoors,
      gender:            GENDER[self.gender.to_sym],
      preferred_pattern: self.preferred_pattern,
      likes_spicy_food:  self.likes_spicy_food ? 1 : 0,
      dominant_hand:     DOMINANT_HAND[self.dominant_hand.to_sym],
      prefers_baths:     self.prefers_baths ? 1 : 0,
      preferred_pet:     PREFERRED_PET[self.preferred_pet.to_sym],
      night_or_day:      NIGHT_OR_DAY[self.night_or_day.to_sym],
    }
  end

  def labelize
    FAVORITE_COLOR[self.favorite_color.to_sym]
  end

  def prediction
    File.open(Rails.root + 'tmp/svm_model', 'wb') { |f| f << REDIS.get('svm_model') }
    model = Model.new('tmp/svm_model')
    prediction = model.predict(self.featureize.values)
    (FAVORITE_COLOR.invert)[prediction.to_i]
  rescue
    'Could not produce a prediction. Try training the SVM!'
  end

  def generate_unique_id!
    until self.unique_id.present?
      self.update_attribute('unique_id', rand(36**8).to_s(36)) rescue nil
    end
  end
end
