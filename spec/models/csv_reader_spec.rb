require "rails_helper"

RSpec.describe CSVReader, :type => :model do
  context 'report parser' do
    let(:csv_row) { ['85512111111','2018-02-13 14:51:13 +0700','SMS',0,1,1,1,0,0] }

    it 'parse csv row to report object' do
      expect(CSVReader.parse(csv_row)).to be_a(Hash)

      expect(CSVReader.parse(csv_row)[:phone_number]).to eq('85512111111')
    end
  end

  context 'Import' do
    let(:dir_path) { File.join(File.dirname(__FILE__), '/../fixtures/') }
    let(:first_csv) { File.join(dir_path, 'w11.csv') }

    before(:each) do
      allow(CSVReader).to receive(:files_in).with(dir_path).and_return([first_csv])
    end

    it 'import csv to report' do
      CSVReader.import(dir_path)

      expect(Report.count).to eq(2)
    end
  end
end
