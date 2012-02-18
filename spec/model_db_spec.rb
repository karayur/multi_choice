require "rspec"
require_relative "../model_db"

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/quizzes4spec.sqlite3")
DataMapper.finalize

describe "get all exercise for the first quiz" do

  it "returns 2 ex for test data" do
    quiz = Quiz.first
    quiz.exercises.length.should eql 2
  end

  it "returns specific data in ex" do
    quiz = Quiz[1]
    quiz.exercises[0].question.should eql "Selects all attributes that are named lang"
  end


end