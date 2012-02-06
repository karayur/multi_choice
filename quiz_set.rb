require_relative "g_spreadsheet"
#require_relative "lib/google_spreadsheet"

class QuizSet


  # @param worksheet [GoogleSpreadsheet::Worksheet]
  def initialize (worksheet)
    @worksheet = worksheet
  end


  # returns number of quiz (rows) in the set
  # @return [Fixnum]
  def count_quizzes
      @worksheet.num_rows
  end


  # To change this template use File | Settings | File Templates.
end


#qs = QuizSet.new (GSpreadsheet.new G_TEST_DOC).get_quiz_worksheet
#
#puts qs.count_quizzes
