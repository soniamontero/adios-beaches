require 'faker'
require 'pry-byebug'

Done.destroy_all
puts 'Deleting dones...'
Favorite.destroy_all
puts "Deleting favorites..."
Vote.destroy_all
puts "Deleting votes..."
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
identicons = ["https://avatars0.githubusercontent.com/u/11577265?s=460&v=4", "https://avatars2.githubusercontent.com/u/12451650?s=460&v=4", "https://avatars1.githubusercontent.com/u/26235955?s=460&v=4", "https://topcoder-prod-media.s3.amazonaws.com/member/profile/Dhirendra24-1521096232990.png"]

10.times do
  faker_name = Faker::Name.first_name

  user = User.create(
    email: Faker::Internet.free_email(name: faker_name),
    password: 'password',
    first_name: faker_name,
    country: Faker::Address.country,
    batch_number: rand(1..320),
    batch_location: lw_cities.sample,
    github_username: Faker::Omniauth.github[:info][:nickname],
    visited_bali: [true, false].sample,
    provider: Faker::Omniauth.github[:provider],
    uid: Faker::Omniauth.github[:uid],
    token: Faker::Omniauth.github[:credentials],
    first_login: false,
    github_picture_url: identicons.sample
  )
p "Generated user: #{faker_name}!"
end


Category.create(name: "Food")
Category.create(name: "Stays")
Category.create(name: "Nature")
Category.create(name: "Arts")
Category.create(name: "Nightlife")
Category.create(name: "Sports")
Category.create(name: "Shopping")
# Category.create(name: "workshops")
puts "Categories generated!"


puts "Starting experiences..."

exp = Experience.create!(
    name: "The lawn in canggu amazing place!",
    address: "The Lawn, Jalan Pura Dalem, Canggu, Kabupaten de Badung, Bali, Indonésie",
    price: 150000,
    price_range: 2,
    details: "Cool place, good cocktails. Expensive but worth a visit!",
    category_id: Category.find_by(name: "Food").id,
    user_id: User.all.pluck(:id).sample,
    remote_photo_url: "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80"
  )
p "Generated one more amazing experience: #{exp.name}..."

exp = Experience.create!(
    name: "The best pizza and pasta in Batu Bolong",
    address: "Pizza Fabbrica, Jalan Pura Dalem, Canggu, Kabupaten de Badung, Bali, Indonésie",
    price: 150000,
    price_range: 2,
    details: "Cool place, good cocktails. Expensive but worth a visit!",
    category_id: Category.find_by(name: "Food").id,
    user_id: User.all.pluck(:id).sample,
    remote_photo_url: "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1334&q=80"
  )
p "Generated one more amazing experience: #{exp.name}..."

exp = Experience.create!(
    name: "Open Water in Amed",
    address: "Dive Concepts, jalan amlapura, Amed, Karangasem Regency, Bali, Indonésie",
    price: 500000000,
    price_range: 2,
    details: "Super experienced divers, the teacher was great. Ask for great, he was nice, professional and super patient. And the prce of te open water is pretty cheap compared to competition. Highly recommanded to anyone! ",
    category_id: Category.find_by(name: "Sports").id,
    user_id: User.all.pluck(:id).sample,
    remote_photo_url: "https://images.unsplash.com/photo-1544551763-46a013bb70d5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80"
  )
p "Generated one more amazing experience: #{exp.name}..."

exp = Experience.create!(
    name: "Best sunset on ricefields at El Passo",
    address: "El Passo, Jl. By Pass Tanah Lot, Munggu, Kec. Mengwi, Kabupaten Badung, Bali, Indonésie",
    price: 30000,
    price_range: 1,
    details: "Fresh beers with the best view on the rice field behing the restaurants. Good for sunset!",
    category_id: Category.find_by(name: "Food").id,
    user_id: User.all.pluck(:id).sample,
    remote_photo_url: "https://images.unsplash.com/photo-1532160515895-a97adb75c4f3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80"
  )
p "Generated one more amazing experience: #{exp.name}..."

exp = Experience.create!(
    name: "Luigi DJ and bar, on fire on Monday",
    address: "El Passo, Jl. By Pass Tanah Lot, Munggu, Kec. Mengwi, Kabupaten Badung, Bali, Indonésie",
    price: 80000,
    price_range: 1,
    details: "Cool pizza with DJ and dancefloor in the back. Beers and cocktails, a lot of people. They have a deal on Ponday as well, worth going! And LW student shave a discount there :) ",
    category_id: Category.find_by(name: "Food").id,
    user_id: User.all.pluck(:id).sample,
    remote_photo_url: "https://images.unsplash.com/photo-1520201163981-8cc95007dd2a?ixlib=rb-1.2.1&auto=format&fit=crop&w=2468&q=80"
  )
p "Generated one more amazing experience: #{exp.name}..."

exp = Experience.create!(
    name: "Cheap food at Warung Sika",
    address: "Warung Sika, Jalan Tanah Barak No.45, Canggu, Kec. Kuta Utara, Kabupaten Badung, Bali, Indonésie",
    price: 42000,
    price_range: 1,
    details: "Fresh warung, cheap and close to Frii, perfect to eat fast!",
    category_id: Category.find_by(name: "Food").id,
    user_id: User.all.pluck(:id).sample,
    remote_photo_url: "https://images.unsplash.com/photo-1559603739-f9d7d50360a2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2500&q=80"
  )
p "Generated one more amazing experience: #{exp.name}..."

exp = Experience.create!(
    name: "Monkey Forest in Ubud",
    address: "Monkey Forest, Jl. Monkey Forest, Ubud, Kecamatan Ubud, Kabupaten Gianyar, Bali, Indonésie",
    price: 50000,
    price_range: 1,
    details: "Monkeys in Bali are so cool. Just go there, bring or buy some bananas, and feed the babies. Cutest little things on earth. No, just kidding, they will try to steal your stuff and maybe even bite you. But still worth it somehow!",
    category_id: Category.find_by(name: "Nature").id,
    user_id: User.all.pluck(:id).sample,
    remote_photo_url: "https://images.unsplash.com/photo-1430462773665-fd261133b47f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1510&q=80"
  )
p "Generated one more amazing experience: #{exp.name}..."

exp = Experience.create!(
    name: "Fruits and veggies market super early",
    address: "Pasar Canggu, Jl. Raya Taman No.88, Seminyak, Kuta, Kabupaten Badung, Bali, Indonésie",
    price: 42000,
    price_range: 1,
    details: "Starts at 5am I think, finishes at 7am. But u can find all the veggies ever there, only locals.",
    category_id: Category.find_by(name: "Food").id,
    user_id: User.all.pluck(:id).sample,
    remote_photo_url: "https://images.unsplash.com/photo-1555876484-a71a693b161b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2468&q=80"
  )
p "Generated one more amazing experience: #{exp.name}..."

exp = Experience.create!(
    name: "Jewellery at Monsieur Blonde in Batu Bolong",
    address: "Monsieur Blonde, Pantai Batu Bolong St No.96a, Canggu, North Kuta, Badung Regency, Bali, Indonésie",
    price: 800000,
    price_range: 2,
    details: "Lot of jewellery, silver and gold plated. Also lingerie!",
    category_id: Category.find_by(name: "Stays").id,
    user_id: User.all.pluck(:id).sample,
    remote_photo_url: "https://images.unsplash.com/photo-1536502829567-baf877a670b5?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80"
  )
p "Generated one more amazing experience: #{exp.name}..."


puts "TROPIC LIKE IT'S HOOOOT!"






















