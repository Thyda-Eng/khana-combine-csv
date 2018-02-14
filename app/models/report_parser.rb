module ReportParser
  def parse csv_row
    {
      phone_number: csv_row[0],
      connector_a: csv_row[3],
      connector_b: csv_row[4],
      connector_c: csv_row[5],
      total_sent_sms: csv_row[7],
      total_received_sms: csv_row[8],
    }
  end
end
