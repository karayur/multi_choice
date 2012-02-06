require "rspec"
require_relative "../g_spreadsheet"


describe GSpreadsheet do


  before :each do

    @g_spreadsheet = GSpreadsheet.new G_TEST_DOC
  end

  describe "#worksheets_names" do

    it "returns rows count (more than 0)" do
      @g_spreadsheet.worksheets_names.length.should > 0
    end

  end

  describe "#get_quiz_worksheet" do
    it "returns worksheet"  do

      @g_spreadsheet.get_quiz_worksheet.class.should == GoogleSpreadsheet::Worksheet

    end
  end

end