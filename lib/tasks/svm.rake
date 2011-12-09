require 'svm'

namespace :svm do
  desc "Compute thetas"
  task :compute => :environment do
    labels = Example.all.map(&:label)
    examples = Example.all.map(&:features)

    problem = Problem.new(labels,examples)
    parameters = Parameter.new(:kernel_type => LINEAR, :C => 10)
    model = Model.new(problem, parameters)

    model.save('tmp/svm_model')
    REDIS.set('svm_model', IO.read(Rails.root + 'tmp/svm_model'))
  end
end
