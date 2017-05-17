# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "Destroying Publication"
Publication.destroy_all
puts "Destroying Bills"
Bill.destroy_all


6.times do
  print "."
  publication = Publication.new(
    title: Faker::Job.title,
    description: Faker::Lorem.paragraph(2),
    customer: Faker::Company.name
  )
  publication.save!
end
