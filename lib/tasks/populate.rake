namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    5.times do |n|
      puts "[DEBUG] creating user #{n+1} of 10"
      name = Faker::Name.name
      email = "user-#{n+1}@example.com"
      password = "password"
      User.create!( 
                    email: email,
                    password: password,
                    password_confirmation: password)
    end
  end
end