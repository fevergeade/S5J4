# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
Comment.destroy_all
JoinTableGossipTag.destroy_all
Gossip.destroy_all
Tag.destroy_all
JoinTablePmRecipient.destroy_all
PrivateMessage.destroy_all
User.destroy_all
City.destroy_all

puts "je commence a peupler la base de donnée"
10.times do
  City.create(
    name: Faker::Address.city,
    zip_code: Faker::Address.zip_code
  )
end
puts "voici la liste des villes créées:"
tp City.all

10.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::ChuckNorris.fact,
    email: Faker::Name.last_name + "@mail.com",
    age:rand(18..120),
    city_id: City.find(rand(City.first.id..City.last.id)).id,
    password: "123456789"
  )
end
puts "voici la liste des utilisateurs créés:"
tp User.all
puts "fin"
20.times do
  Gossip.create(
    title: Faker::GreekPhilosophers.name,
    content: Faker::GreekPhilosophers.quote,
    user_id: User.find(rand(User.first.id..User.last.id)).id
  )
end
puts "voici la liste des gossips créés:"
tp Gossip.all

10.times do
  Tag.create(title: "#" + Faker::Verb.base)
end
puts "voici la liste des tags créés:"
tp Tag.all

Gossip.all.each do |gossip|
  rand(1..5).times do
    JoinTableGossipTag.create(
      tag_id: Tag.find(rand(Tag.first.id..Tag.last.id)).id,
      gossip_id: gossip.id
    )
  end
end
puts "Pour chaque gossip, j'ai rattaché 1 à 5 Tag"
puts "voici la liste des liens tags-gossip créés:"
tp JoinTableGossipTag.all

Gossip.all.each do |gossip|
  rand(1..5).times do
    Comment.create(
      content: Faker::ChuckNorris.fact,
      user_id: gossip.user.id,
      gossip_id: gossip.id
    )
  end
end
puts "Pour chaque gossip, j'ai rattaché 1 à 5 commentaire"
puts "voici la liste des commentaires créés:"
tp Comment.all


5.times do
  PrivateMessage.create(
    content: Faker::ChuckNorris.fact,
    sender_id: User.find(rand(User.first.id..User.last.id)).id
  )
end
puts "voici la liste des private_messages créés:"
tp PrivateMessage.all

PrivateMessage.all.each do |privateMessage|
  rand(1..5).times do
    JoinTablePmRecipient.create(
      private_message_id: privateMessage.id,
      recipient_id: User.find(rand(User.first.id..User.last.id)).id
    )
  end
end
puts "Pour chaque private_message, j'ai rattaché 1 à 5 destinataire"
tp JoinTablePmRecipient.all
