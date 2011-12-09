class ExampleJob
  @queue = :examples

  def self.perform(survey_id)
    @survey = Survey.find(survey_id)
    @survey.example.destroy if @survey.example.present?
    @survey.example = Example.create(@survey.featureize)
  end
end
