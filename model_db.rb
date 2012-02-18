require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
require 'data_mapper'


DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/quizzes.sqlite3")


class Exercise
  include DataMapper::Resource

  property :id,                Serial   # primary serial key
  property :question,          String
  property :correct_answer,    String
  property :wrong_answer1,     String
  property :wrong_answer2,     String
  property :wrong_answer3,     String
  property :wrong_answer4,     String
  property :comment,           String

  belongs_to :quiz

end

class Quiz
  include DataMapper::Resource

  property :id,            Serial   # primary serial key
  property :name,          String

  has n, :exercise
end


DataMapper.finalize
DataMapper.auto_upgrade!
#

#DataMapper.auto_migrate!