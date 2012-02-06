require "rspec"
require_relative "../quiz_set"

describe QuizSet do

  before :each do

    g_spreadsheet = GSpreadsheet.new G_TEST_DOC
    @quiz_set = QuizSet.new (g_spreadsheet.get_quiz_worksheet)


  end

  describe "#count_quizzes"
  it "should return number of quizzes" do
      @quiz_set.count_quizzes.should eql 7
  end
end