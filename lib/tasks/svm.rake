require 'svm'

namespace :svm do
  desc "Compute thetas"
  task :train => :environment do
    labels = Example.training_set.map(&:label)
    examples = Example.training_set.map(&:features)
    cv_labels = Example.cv_set.map(&:label)
    cv_examples = Example.cv_set.map(&:features)

    puts "Training SVM on #{examples.length} examples..."

    problem = Problem.new(labels,examples)
    parameters = Parameter.new(:kernel_type => LINEAR, :C => 10)
    model = Model.new(problem, parameters)

    model.save('tmp/svm_model')
    model_dump = IO.read(Rails.root + 'tmp/svm_model')
    REDIS.set('svm_model', model_dump)
    REDIS.set('last_trained', Time.now)

    errors = cv_examples.each_with_index.map do |cv_example, i|
      model.predict(cv_example).to_i == cv_labels[i] ? 0 : 1
    end

    mean_error = errors.inject { |sum, er| sum + er }.to_f / errors.size
    REDIS.set('cv_error', mean_error)

    puts "Trained SVM. CV error: #{mean_error}"

    puts 'Model output follows ' + '-' * 59
    puts model_dump
    puts '-' * 80
  end
end
