require "rspec"
require_relative "../x_quiz"

describe "#init_from_array" do

  TEST_ARRAY = [["Question", "Answer",	"Wrong Answer 1",	"Wrong Answer 2",	"Wrong Answer 3",	"Wrong Answer 4",	"Comments"],
                  ["How to mark class property?", 	"@@property",	"@self.property",	"@property,	self.@property",	"not possible", "" ],
                  ["2 How to mark class property?", 	"2 @@property",	"2 @self.property",	"2 @property,	self.@property",	"2 not possible", "2 " ]
                ]

  it "should convert array to quiz xml" do

    x_quiz = XQuiz.new
    x_quiz.init_from_array "Test name", "Test group",  TEST_ARRAY
    #x_answer = x_quiz.quiz_xml.xpath(''//answer[@is_correct=='true']").first

    x_answer = x_quiz.quiz_xml.xpath('//answer[@is_correct="true"]').first
    x_answer.text.should eql "@@property"

    x_answer = x_quiz.quiz_xml.xpath('//answer')[1]
    x_answer.text.should eql "@self.property"

  end
end