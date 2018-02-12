namespace :csv do
  desc "combine all report to single report file"
  task :combine,[:source_path, :destination_path] => :environment do |t, args|
    CSVReader.combine(args[:source_path], args[:destination_path])
  end

end
