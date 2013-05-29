namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    4.times do |n|
      puts"[DEBUG] creating user #{n+1} of 10"
      name = Faker::Name.name 
      email ="user-#{n+1}@example.com"
      password ="password"
      User.create!(name: name,
                  email: email,
                  password: password,
                  password_confirmation: password)
    end
    User.all.each do |user|
      puts "[DEBUG] creating article for user #{user.id} of #{User.last.id}"
      4.times do|n|
        title = %w(cool awesome crazy nice beautiful adorable incredible).sample
        body = ['Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vitae cursus dolor. 
                 Morbi malesuada justo a ipsum accumsan egestas. Morbi aliquet, 
                 tellus vitae euismod interdum, lectus massa scelerisque eros, 
                 vel hendrerit nisl metus in justo. Donec in sagittis purus. 
                 Duis eu purus quis ante cursus placerat ac et dolor. 
                 Morbi vitae dui urna, sed dictum enim. Pellentesque id dui sit amet erat sodales 
                 feugiat sit amet ut diam']
        location = %w(seattle boston santiago)
        published_at = DateTime.now 
        slug = title 
        user.articles.create!(title: title, 
                              body: body,
                              location: location,
                              published_at: published_at,
                              slug: slug)
      end    
   end 
  end
end