require "rspec"
require_relative "../quiz_set"
require_relative "describe_internally"

describe QuizSet do

  before :all do
    g_spreadsheet = GSpreadsheet.new G_TEST_DOC
    @quiz_set = QuizSet.new (g_spreadsheet.get_quiz_worksheet)
  end

  describe "#count_quizzes"  do
    it "returns number of quizzes " do
       @quiz_set.count_quizzes.should > 0
    end

    it "return number of quizzes from test doc should equal to 7" do
        @quiz_set.count_quizzes.should eql 7
    end
  end

  describe "#to_xml" do
    it "returns quizzes in xml format" do
      true.should == false
    end
  end
end


describe_internally QuizSet do
  before :all do
    g_spreadsheet = GSpreadsheet.new G_TEST_DOC
    @quiz_set = QuizSet.new (g_spreadsheet.get_quiz_worksheet)
  end


  describe "#get_columns_names" do
    it "returns array" do
        @quiz_set.get_columns_names.class.should eql Array
    end

    it "returns 7 columns with test document" do
        puts "Columns in the test docs are:" + @quiz_set.get_columns_names.to_s
        @quiz_set.get_columns_names.should have(7).Items
    end
  end

  describe "#set_column_mapping" do
     it "should properly identify mapping for test document" do
        @quiz_set.set_column_mapping.should == {:question=>0, :correct_answer=>1, :wrong_answer_1=>2, :wrong_answer_2=>3, :wrong_answer_3=>4, :wrong_answer_4=>5, :id=>6}
     end
  end

end
