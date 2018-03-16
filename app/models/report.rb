require 'csv'
require 'date'

class Report < ApplicationRecord
  belongs_to :device
  has_one :category, through: :device

  validates :timestamp, presence: true
  validates :status, inclusion: {in: ["online","offline"]}
  validates :timestamp, uniqueness: {:scope => [:device_id, :status]}

  def self.load_data
    csv_folder = "db/csv/"
    csv_options = { headers: :first_row, header_converters: :symbol }
    newest_file_path = Dir.glob("#{csv_folder}*").max_by {|f| File.mtime(f)} #always loading the latest file in the folder
    CSV.foreach(newest_file_path, csv_options) do |row|
      timestamp = DateTime.parse(row[:timestamp])
      serial = row[:id]
      device_id = Device.load_or_find(serial,row[:type])
      status = row[:status]
      report = Report.new(timestamp: timestamp, device_id: device_id, status: status)
      report.save
    end
  end
end
