require_relative "g_spreadsheet"
require_relative "lib/google_spreadsheet"
require "rexml/element"
require "rexml/document"

class QuizSet

  # multiple choice columns aliases in spreadsheet
  MC_COLUMNS_ALIAS = {:id           => "ID",
                    :question       => "Text 1",
                    :correct_answer => "Text 2",
                    :wrong_answer_1 => "Wrong Answer 1",
                    :wrong_answer_2 => "Wrong Answer 2",
                    :wrong_answer_3 => "Wrong Answer 3",
                    :wrong_answer_4 => "Wrong Answer 4"}

  # @param worksheet [GoogleSpreadsheet::Worksheet]
  def initialize (worksheet)
    @worksheet = worksheet
    set_column_mapping
  end

  # returns number of quiz (rows) in the set
  # @return [Fixnum]
  def count_quizzes
      @worksheet.num_rows
  end

  def to_xml

    quiz_set_xml = REXML::Element.new "quiz_set"

    quiz_set_xml.add_element("spreadsheet_title").add_text @worksheet.spreadsheet.title
    quiz_set_xml.add_element("quiz_set_title").add_text             @worksheet.title
    quiz_set_xml.add_element("id_url").add_text            @worksheet.worksheet_feed_url

    quizzes_xml = quiz_set_xml.add_element ("quizzes")
    quiz_set_xml.add_element quizzes_xml

    @worksheet.rows(1).each do |row|
    quiz_xml = REXML::Element.new ("quiz")

      # create wrong_answers container
      wrong_answers_xml = REXML::Element.new ("wrong_answers")

      # iterate through multiple choice fields
      MC_COLUMNS_ALIAS.keys.each do |field_id|
        # extract value of the field (to be added into xml)
        value = row[@columns_maps[field_id]]

        # wrong answers are going to a separate element
        if  field_id.to_s[0,12] == "wrong_answer"
          wrong_answers_xml.add_element("wrong_answer").add_text(value)
        else
          quiz_xml.add_element(field_id.to_s).add_text(value)
        end
      end
      quiz_xml.add_element    wrong_answers_xml
      quizzes_xml.add_element quiz_xml
    end
    quiz_set_xml
  end

  private # ------------------------------ PRIVATE METHODS ---------------------------------

  # create map between column id in spreadsheet and alias
  def set_column_mapping
    @columns_maps = {}

    column_alias =  MC_COLUMNS_ALIAS.invert

    # check if column name in worksheet has an alias - if so - save the column id
    column_names = get_columns_names
    column_names.each_index do |i|
      if column_alias[column_names[i]] != nil
         @columns_maps[column_alias[column_names[i]]] = i
      end
    end

    @columns_maps # we return it only for tests
  end

  # @return [Array]
  def get_columns_names
     @worksheet.rows[0]
  end

end


qs = QuizSet.new (GSpreadsheet.new G_TEST_DOC).get_quiz_worksheet
#
puts qs.to_xml
