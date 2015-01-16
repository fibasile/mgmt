require "google/api_client"
require "google_drive"

namespace :google_sheets do

  client = Google::APIClient.new
  auth = client.authorization
  auth.client_id = ENV['google_drive_client_id']
  auth.client_secret = ENV['google_drive_secret']
  auth.scope = "https://www.googleapis.com/auth/drive " + "https://spreadsheets.google.com/feeds/"
  auth.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"

  desc "Get credentials"
  task :get_credentials => :environment do    
    print("1. Open this page:\n%s\n\n" % auth.authorization_uri)
  end
  
  desc "Exports to Sheets"
  task :export => :environment do
    
    if ENV['AUTH_CODE'].present?
      auth.code = ENV['AUTH_CODE']
      auth.fetch_access_token!
      access_token = auth.access_token
    else
      access_token = ENV['ACCESS_TOKEN']
    end
    p access_token
    session = GoogleDrive.login_with_oauth(access_token)
    ws = session.spreadsheet_by_key(ENV['google_drive_spreadsheet_key']).worksheets[0]
    
    ws[1,1] = "id"
    ws[1,2] = "photo"
    ws[1,3] = "first name"
    ws[1,4] = "last name"
    ws[1,5] = "email"
    ws[1,6] = "country"
    ws[1,7] = "studio"
    ws[1,8] = "oblig seminar"
      Course::SEMINARS.keys.each_with_index do |key, index|
        index = index + 9
        ws[1,index] = Course::SEMINARS[key]
      end

    User.all.each_with_index do |user, i|
      i += 2
      ws[i,1] =  user.id
      ws[i,2] =  "=IMAGE(\"#{user.photo}\",4,50,50)"
      ws[i,3] =  user.first_name
      ws[i,4] =  user.last_name
      ws[i,5] =  "=HYPERLINK(\"mailto:#{user.email}\",\"#{user.email}\")"
      ws[i,6] =  user.country
      ws[i,7] =  Course::STUDIOS[user.studio]
      ws[i,8] =  user.oblig_seminar
      Course::SEMINARS.keys.each_with_index do |key, index|
        index = index + 9
        ws[i,index] = [user.seminar_1, user.seminar_2].include?(key) ? "TRUE" : nil
      end
      
    end

    ws.save()
  end

end



