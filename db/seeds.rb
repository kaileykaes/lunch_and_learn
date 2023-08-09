# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
password_example = Faker::Music::Opera.gounod 

user = User.create!({
  name: Faker::Music::Hiphop.artist, 
    email: "#{Faker::Movies::HowToTrainYourDragon.dragon}@gmail.com", 
    password: password_example, 
    password_confirmation: password_example 
})

5.times do 
  Favorite.create!({
    country: Faker::Movies::LordOfTheRings.location,
    recipe_link: Faker::Creature::Bird.emotional_adjective, 
    recipe_title: Faker::Movies::PrincessBride.quote, 
    user: user
  }) 
end





