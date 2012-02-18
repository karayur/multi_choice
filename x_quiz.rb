require "nokogiri"

class XQuiz

  attr_reader :quiz_xml

  # @param quiz_xml[Nokogiri::XML]
  def initialize (quiz_xml = nil)
    quiz_xml = Nokogiri::XML("<quiz/>") if quiz_xml == nil
    @quiz_xml = quiz_xml
  end

  # @param quiz_name [String] - could be name of worksheet (in google docs)
  # @param quiz_group [String] - could be name of spreadsheet (in google docs)
  # @param quiz_array [Array]
  # Process two-dimension array. There we assume that first row have column names with next sequence
  # Question,	Answer,	Wrong Answer 1,	Wrong Answer 2,	Wrong Answer 3,	Wrong Answer 4,	Comment
  def init_from_array (quiz_name, quiz_group, quiz_array)
    quiz = @quiz_xml.xpath("//quiz").first
    #@quiz_xml.add_child("name")
    #quiz.content = "text"
    quiz.add_child("<name/>").first.content  = quiz_name
    quiz.add_child("<group/>").first.content = quiz_group
    exercises = quiz.add_child("<exercises/>").first

    # start from 1 to skip column names
    for i in 1..quiz_array.length - 1 do

      exercise = exercises.add_child("<exercise/>").first
      exercise.add_child("<question/>").first.content = quiz_array[i][0]
      exercise.add_child("<answer is_correct='true'>").first.content = quiz_array[i][1]
      exercise.add_child("<answer/>").first.content = quiz_array[i][2]
      exercise.add_child("<answer/>").first.content = quiz_array[i][3]
      exercise.add_child("<answer/>").first.content = quiz_array[i][4]
      exercise.add_child("<answer/>").first.content = quiz_array[i][5]
      exercise.add_child("<comment/>").first.content = quiz_array[i][5]
    end

  end

  # @param file_path [String]
  #def init_from_file (file_path)
  #  file = File.open file_path
  #  @quiz_xml = Nokogiri::XML(file)
  #  file.close
  #end

end

TEST_ARRAY = [["Question", "Answer",	"Wrong Answer 1",	"Wrong Answer 2",	"Wrong Answer 3",	"Wrong Answer 4",	"Comments"],
                ["How to mark class property?", 	"@@property",	"@self.property",	"@property,	self.@property",	"not possible", "" ],
                ["2 How to mark class property?", 	"2 @@property",	"2 @self.property",	"2 @property,	self.@property",	"2 not possible", "2 " ]
              ]

test_x = XQuiz.new
test_x.init_from_array("Past Perfect", "Simple base", TEST_ARRAY)
puts test_x.quiz_xml.to_xml