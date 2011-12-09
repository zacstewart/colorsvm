require 'svm'

class TrainingJob
  @queue = :theta_calculations

  def self.perform
    labels = Example.all.map(&:label)
    examples = Example.all.map(&:features)

    problem = Problem.new(labels,examples)
    parameters = Parameter.new(:kernel_type => LINEAR, :C => 10)
    model = Model.new(problem, parameters)

    model.save('tmp/svm_model')
    redis = Redis.new
    redis.set('svm_model', IO.read(Rails.root + 'tmp/svm_model'))
  end
end
