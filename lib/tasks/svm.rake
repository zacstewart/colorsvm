require 'svm'

namespace :svm do
  desc "Compute thetas"
  task :train => :environment do
    labels = Example.trainable.map(&:label)
    examples = Example.trainable.map(&:features)

    puts "Training SVM on #{examples.length} examples..."

    problem = Problem.new(labels,examples)
    parameters = Parameter.new(:kernel_type => LINEAR, :C => 10)
    model = Model.new(problem, parameters)

    model.save('tmp/svm_model')
    model_dump = IO.read(Rails.root + 'tmp/svm_model')
    REDIS.set('svm_model', model_dump)
    REDIS.set('last_trained', Time.now)

    puts 'Trained SVM. Model output follows ' + '-' * 46
    puts model_dump
    puts '-' * 80
  end
end
