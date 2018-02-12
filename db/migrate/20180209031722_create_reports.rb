class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :phone_number
      t.integer :week
      t.integer :index
      t.integer :connector_a
      t.integer :connector_b
      t.integer :connector_c
      t.integer :total_sent_sms
      t.integer :total_received_sms

      t.timestamps null: false
    end
  end
end
