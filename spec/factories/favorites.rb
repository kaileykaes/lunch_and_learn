FactoryBot.define do
  factory :favorite do
    country { Faker::Creature::Horse.breed } 
    recipe_link { Faker::Creature::Bird.emotional_adjective } 
    recipe_title { Faker::Creature::Animal.name }
    :user 
  end
end
