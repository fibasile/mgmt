require 'csv'

namespace :check do
  
  desc "Checks data"
  task :data => :environment do
    User.all.each do |user|
      raise "email #{user.id} #{user.email}" unless user.email.include? "iaac.net"
      %w(photo password_digest email gender studio oblig_seminar seminar_1 seminar_2 country_code invitation_code first_name last_name).each do |w|
        p "#{w} missing for #{user.id} #{user.email}" if user.send(w.to_s).blank?
      end
    end
  end


  task :final => :environment do
    Rails.logger.level = 2
    CSV.foreach("finalfinal.csv").drop(2).each do |row|
      begin
        user = User.includes(:received_grades).find(row[0])
        p "email" unless user.email == row[1]
        p "first name" unless user.first_name == row[3]
        p "last name" unless user.last_name == row[4]
        p "ic1 #{user.email} #{user.received_grades.where(course_id: 39).first.to_s} != #{row[5].to_s}" unless user.received_grades.where(course_id: 39).first.to_s == row[5].to_s
        p "ic2 #{user.email} #{user.received_grades.where(course_id: 40).first.to_s} != #{row[6].to_s}" unless user.received_grades.where(course_id: 40).first.to_s == row[6].to_s
        p "ic3 #{user.email} #{user.received_grades.where(course_id: 41).first.to_s} != #{row[7].to_s}" unless user.received_grades.where(course_id: 41).first.to_s == row[7].to_s
        p "ic4 #{user.email} #{user.received_grades.where(course_id: 42).first.to_s} != #{row[8].to_s}" unless user.received_grades.where(course_id: 42).first.to_s == row[8].to_s
        p "g1 #{user.email} #{user.received_grades.where(course_id: 45).first.to_s} != #{row[11].to_s}" unless user.received_grades.where(course_id: 45).first.to_s == row[11].to_s
        p "g2 #{user.email} #{user.received_grades.where(course_id: 46).first.to_s} != #{row[12].to_s}" unless user.received_grades.where(course_id: 46).first.to_s == row[12].to_s
      rescue Exception => e
        p e, row
      end
    end
  end

end
