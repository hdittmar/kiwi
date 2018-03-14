require 'date'

class Device < ApplicationRecord
  has_many :reports

  validates :serial, presence: true
  validates :category, presence: true
  validates :category, inclusion: {in: ["sensor","gateway"]}

  def self.load_or_find(serial, category)
    if device = Device.find_by_serial(serial)
      raise "Type does not match previous device with this serial" unless device.category == category
      id = device.id
    else
      device = Device.new(serial:serial, category:category)
      device.save
      id = device.id
    end
    return id
  end

  def self.get_most_popular(date)
    todays_frequency = Report.where(timestamp: date.all_day).group(:device_id).count
    last_weeks_frequencies = Report.where(timestamp: (date-7.days).all_day).group(:device_id).count
    top_ten = todays_frequency.sort_by {|id, frequency| -frequency}[0..9]
    lowest_frequency = top_ten[-1][1]
    #now make sure to also get all the devices that also have the same frequency as the lowest in the top 10
    all_lowest_frequency_devices = todays_frequency.select {|key,value| value == lowest_frequency}
    all_lowest_frequency_devices.each {|key,value| top_ten << [key,value] unless top_ten.include?([key,value])}
    create_result_hash(top_ten, last_weeks_frequencies)
  end

  private

  def self.create_result_hash(top_devices, last_weeks_frequencies)
    results = []
    top_devices.each do |array|
      device_id = array[0]
      frequency = array[1]
      device = Device.find(device_id)
      change = calculate_percentage_change(device_id, frequency, last_weeks_frequencies)
      results << {serial: device.serial, category: device.category, frequency: frequency, change: change}
    end
    results
  end

  def self.calculate_percentage_change( device_id, frequency, last_weeks_frequencies)
    last_freq = last_weeks_frequencies[device_id] ? last_weeks_frequencies[device_id] : 0
    return percentage_change = last_freq != 0 ? (((frequency - last_freq) / last_freq.to_f) * 100) : "n/a"
  end
end
