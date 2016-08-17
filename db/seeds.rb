# 10.times do |n|
#   email = Faker::Internet.email
#   password = "password"
#   User.create!(
#               name: "Test Diver#{n}",
#               email: email,
#               password: password,
#               password_confirmation: password,
#               uid: "#{n}"
#               )
# end


# 3.times do |n|
#   email = Faker::Internet.email
#   password = "password"
#   name = Faker::Name.name
#   uid = Faker::Code.ean
#   provider = Faker::Company.name
#   #image_url = File.open(Dir.glob(File.join(Rails.root, 'sampleusers', '*')).sample)
#   User.create!(email: email,
#               name: name,
#               password: password,
#               password_confirmation: password,
#               uid: uid,
#               provider: provider,
#               #image_url: image_url,
#               #avatar: image_url,
#               )

# user = User.all.order(id: :desc).first
# 3.times do |n|
#     user_id = user.id
#     photo = File.open(Dir.glob(File.join(Rails.root, 'sampleimages', '*')).sample)
#     content = Faker::Lorem.sentence
#   Topic.create!(user_id: user_id,
#               photo: photo,
#               content: content,
#               )
# end

# end