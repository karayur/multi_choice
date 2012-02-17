require "rubygems"
#require "bundler/setup"
require "google_spreadsheet"
require_relative "constants"


class GSpreadsheet
  @@session = nil

  def initialize (url)

    @@session = GoogleSpreadsheet.login(G_USER, G_PASSWORD) if @@session == nil
    @spreadsheet = @@session.spreadsheet_by_url (url)

  end

  # return array of worksheet names
  def worksheets_names
    w_names = []
    @spreadsheet.worksheets.each do |ws|
      w_names << ws.title
    end

    puts w_names
    w_names
  end

  def get_quiz_worksheet
    @spreadsheet.worksheets[0]
  end

  def get_worksheet_as_array(worksheet_id)

    @spreadsheet.worksheets[0].rows
  end

end

 #g_spreadsheet = GSpreadsheet.new G_TEST_DOC
 #puts g_spreadsheet.worksheets_names
 #puts g_spreadsheet.get_quiz_worksheet.inspect
 #puts g_spreadsheet.get_quiz_worksheet.class == GoogleSpreadsheet::Worksheet

## First worksheet of http://spreadsheets.google.com/ccc?key=pz7XtlQC-PYx-jrVMJErTcg&hl=en
#ws = session.spreadsheet_by_key("0AtBo7K5vPivBdGplTzhXSkdOSmwxOF9wWXd2ck5Lanc").worksheets[0]
#
## Gets content of A2 cell.
#p ws[1, 1] #==> "hoge"
#
## Changes content of cells. Changes are not sent to the server until you call ws.save().
#ws[5, 5] = "Тест"
#ws[5, 4] = "bar"
#ws.save()
#
## Dumps all cells.
#for row in 1..ws.num_rows
#  for col in 1..ws.num_cols
#    p ws[row, col]
#  end
#end
#
## Yet another way to do so.
#p ws.rows #==> [["fuga", ""], ["foo", "bar]]
#
## Reloads the worksheet to get changes by other clients.
#ws.reload()

