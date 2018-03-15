namespace :db do
  desc "TODO"
  task load_new: :environment do
    puts "executed"
    Report.load_data
    puts "loaded"
  end

end
