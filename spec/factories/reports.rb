FactoryBot.define do
  factory :report do
    phone_number 
    week  1
    index 1
    connector_a 0
    connector_b 0
    connector_c 0
    total_sent_sms 0
    total_received_sms 0
  end
end
