require 'faker'
require 'pry-byebug'

Experience.destroy_all
puts "Deleting experiences..."
Category.destroy_all
puts "Deleting categories..."
User.destroy_all
puts "Deleting users..."

lw_cities = [
  "bordeaux", "lille", "lyon", "marseille", "nantes", "paris", "rennes",
  "amsterdam", "barcelona", "berlin", "brussels", "copenhagen", "lausanne",
  "lisbon", "london", "madrid", "milan", "oslo", "rome", "bali", "chengdu",
  "kyoto", "melbourne", "shanghai", "shenzhen", "singapore", "tokyo",
  "belo horizonte", "buenos aires", "mexico", "montreal", "rio de janeiro",
  "são paulo", "casablanca", "tel aviv"
]

# addresses = %w(Canggu Kuta Nusa-Dua Ubud Lovina Amed Tulamben Bingin Uluwatu
# Dreamland-beach Denpasar Jimbaran Pererenan Penida Lombok Sulawesi)

addresses = ["Canggu", "Canggu North", "next to Canggu", "Kuta", "Amed"]

10.times do
  faker_name = Faker::Name.first_name

  user = User.create(
    email: Faker::Internet.free_email(name: faker_name),
    password: 'password',
    first_name: faker_name,
    batch_number: rand(1..320),
    batch_location: lw_cities.sample,
    github_username: Faker::Omniauth.github[:info][:nickname],
    visited_bali: [true, false].sample,
    provider: Faker::Omniauth.github[:provider],
    uid: Faker::Omniauth.github[:uid],
    token: Faker::Omniauth.github[:credentials],
    first_login: false,
    github_picture_url: Faker::Omniauth.github[:extra][:raw_info][:avatar_url]
  )
p "Generated user: #{faker_name}!"
end


Category.create(name: "food")
Category.create(name: "stays")
Category.create(name: "nature")
Category.create(name: "arts")
Category.create(name: "nightlife")
Category.create(name: "sports")
Category.create(name: "workshops")
puts "Categories generated!"


puts "Starting experiences..."

16.times do
  experience = Experience.create(
    name: Faker::Hipster.sentence,
    address: addresses.sample,
    price: rand(0..150),
    details: Faker::Hipster.paragraph(sentence_count: 6),
    category_id: Category.all.pluck(:id).sample,
    user_id: User.all.pluck(:id).sample
  )
  p "Generated one more amazing experience: #{experience.name}..."
end

puts "TROPIC LIKE IT'S HOOOOT!"
