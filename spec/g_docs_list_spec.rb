require "rspec"
require_relative '../g_docs_list'

describe GDocsList do


  describe "##getQuizFilesList" do

    it "should return XML with google docs links" do

      docs_list = GDocsList.get_quiz_files_list

      puts "There are " + docs_list.elements.size.to_s + " documents"
      docs_list.elements.size.should > 0

    end

  end


end