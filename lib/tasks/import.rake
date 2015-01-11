require 'csv'

namespace :import do
  desc "Imports CSV"
  task :csv => :environment do
    CSV.foreach("grades.csv") do |row|
      p row.first
    end
  end
end

# 'ID'
# 'email'
# 'photo'
# 'First Name'
# 'Last Name'