require 'csv'

namespace :import do
  
  desc "Imports CSV"
  task :csv => :environment do
    csvs = CSV.foreach("grades.csv").to_a
    titles = csvs.shift
    csvs.each do |row|
      user = User.find_or_create_by!(id: row[0]) do |u|
        u.email = row[1]
        u.first_name = row[3]
        u.last_name = row[4]
        u.password = 'password'
      end

      (5..12).each do |i|
        if row[i].present?
          course = Course.where(name: titles[i]).first
          user.courses_studied << course
          Grade.create!(course: course, gradee: user, value: row[i])
        end
      end

      p user.id
    end
  end



  task :ic1 => :environment do
    CSV.foreach("ic1.csv").drop(1).each do |row|
      begin
        grade = Grade.where(gradee_id: row[0], course_id: 39).first
        grade.public_notes = row[6]
        grade.save!
      rescue NoMethodError
        p row
      end
    end
  end

  task :ic2 => :environment do
    CSV.foreach("ic2.csv").drop(1).each do |row|
      begin
        grade = Grade.where(gradee_id: row[0], course_id: 40).first
        grade.public_notes = row[7]
        grade.save!
      rescue NoMethodError
        p row
      end
    end
  end

  task :final => :environment do
    CSV.foreach("final.csv").drop(2).each do |row|
      begin
        user = User.find(row[0])
        user.studio = row[21]
        user.seminar_1 = row[28]
        user.seminar_2 = row[29]
        user.save!
      rescue NoMethodError
        p row
      end
    end
  end

  task :distribution => :environment do
    User.update_all(temp_data: nil)
    CSV.foreach("distribution.csv").drop(2).each do |row|
      begin
        user = User.where(first_name: row[0].strip, last_name: row[1].strip).first
        user.studio = row[7]
        user.oblig_seminar = row[14]
        user.seminar_1 = row[15]
        user.seminar_2 = row[16]
        user.save!
      rescue Exception => e
        raise e, row
      end
    end
  end

  task :users => :environment do
    CSV.foreach("users.csv").drop(1).each do |row|
      begin
        user = User.find(row[0])
        user.country_code = row[1]
        user.photo = row[2]
        user.gender = row[3]
        user.dob = row[4]
        # user.mach_id = row[5]
        user.save!
      rescue Exception => e
        p row
      end
    end
  end

end
