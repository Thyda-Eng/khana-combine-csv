class CSVReader
  require 'csv'

  def self.combine(source_path, destination_path)
    self.import(source_path)
    self.export(destination_path)
  end

  private
  def self.import(path)
    files = Dir.glob("#{path}/*.csv")
    files.each do |file|
      csv_text = File.read(file)
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        report = Report.find_or_initialize_by(phone_number: row[0])
        report.phone_number = row[0]
        report.week = csv.headers[3].match(/w([^\/.]*).*$/)[1]
        report.index = csv.headers[3].match(/w\d+.([^\/.-]*)/)[1]
        report.connector_a = row[3]
        report.connector_b = row[4]
        report.connector_c = row[5]
        report.total_sent_sms = row[7]
        report.total_received_sms = row[8]
        report.save
      end
    end
  end

  def self.export(path)
    mapping_weeks = Report.select(:week, :index).uniq.map{|f| [f.week, f.index]}
    column_headers = self.headers(mapping_weeks)
    CSV.open(path, 'w', write_headers: true, headers: column_headers) do |csv|
      self.body.each do |phone_number, item|
        cols = [phone_number]
        total_sent_sms = 0
        total_received_sms = 0

        mapping_weeks.each do |tmp|
          week = tmp[0]
          index = tmp[1]

          if !item[week].nil? && !item[week][index].nil?
            total_sent_sms = total_sent_sms + item[week][index][:total_sent_sms]
            total_received_sms = total_received_sms + item[week][index][:total_received_sms]

            cols = cols + [item[week][index][:connector_a],
                     item[week][index][:connector_b],
                     item[week][index][:connector_c]]
          else
            cols = cols + [nil, nil, nil]
          end

        end

        cols = cols + [total_sent_sms, total_received_sms]
        csv << cols

      end
    end
  end


  def self.headers(mapping_weeks)
    headers = ["Phone Number"]
    mapping_weeks.each do |tmp|
      week = tmp[0]
      index = tmp[1]
      headers = headers + ["w#{week}.#{index}-connector-a",
                           "w#{week}.#{index}-connector-b",
                           "w#{week}.#{index}-connector-c"]
    end
    headers= headers + ["total_sent_sms", "total_received_sms"]
  end

  def self.body
    items = {}
    Report.all.each do |report|
      item = items[report.phone_number] || {}
      if item[report.week]
        item[report.week][report.index] = {connector_a: report.connector_a,
                                           connector_b: report.connector_b,
                                           connector_c: report.connector_c,
                                           total_sent_sms: report.total_sent_sms,
                                           total_received_sms: report.total_received_sms
                                          }
      else
        item[report.week] = {report.index =>
                                          {connector_a: report.connector_a,
                                           connector_b: report.connector_b,
                                           connector_c: report.connector_c,
                                           total_sent_sms: report.total_sent_sms,
                                           total_received_sms: report.total_received_sms
                                          }

                            }
      end

      items[report.phone_number] = item
    end
    return items
  end

end
