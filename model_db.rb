require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
require 'data_mapper'
require 'nokogiri'
require 'dm-serializer'
require_relative "model_xml"



class Exercise
  include DataMapper::Resource
  include ModelXml

  property :id,                Serial   # primary serial key
  property :question,          String
  property :correct_answer,    String
  property :wrong_answer1,     String
  property :wrong_answer2,     String
  property :wrong_answer3,     String
  property :wrong_answer4,     String
  property :comment,           String

  belongs_to :quiz

  def to_xml
    x_doc = new_document
    x_exercise = root_node     x_doc,  "exercise", "id" => self.id.to_s

    add_node x_exercise, "question", self.question
    add_node x_exercise, "answer",   self.correct_answer, "id"=>"0","is_correct"=>"true"
    add_node x_exercise, "answer",   self.wrong_answer1,  "id"=>"1"
    add_node x_exercise, "answer",   self.wrong_answer2,  "id"=>"2"
    add_node x_exercise, "answer",   self.wrong_answer3,  "id"=>"3"
    add_node x_exercise, "answer",   self.wrong_answer4,  "id"=>"4"
    add_node x_exercise, "comment",  self.comment

    x_doc
  end
end

class Quiz
  include DataMapper::Resource
  include ModelXml

  property :id,            Serial   # primary serial key
  property :name,          String

  has n, :exercises

  def to_xml
    x_doc = new_document
    x_quiz = root_node     x_doc,  "quiz", "id" => self.id.to_s
    add_node               x_quiz, "name",      self.name
    x_exercises = add_node x_quiz, "exercises", nil

    self.exercises.each do |exercise|
      add_xml x_exercises, exercise.to_xml
    end

    x_doc
  end

end

#DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/quizzes.sqlite3")
#DataMapper.finalize
#DataMapper.auto_upgrade!
##
#
#quiz = Quiz.first
#puts quiz.to_xml

#puts Exercise.first.to_xml
#puts Exercise.first.new_document
#
#puts quiz.exercises[0].question

#DataMapper.auto_migrate!