class AddSurveyIdToExamples < ActiveRecord::Migration
  def change
    add_column :examples, :survey_id, :integer
  end
end
