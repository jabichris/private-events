# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
u = User.new( { username: 'Mainuser' })
u.save

10.times do |index|
    u2 = User.new( { username: "User #{index + 2}" })
    u2.save
    e = Event.new( { title: "Private Event #{index + 2}",
                     date: '2020-05-20 14:30:00',
                     accessibility: true } )
    u2.events.push(e)
    i = Invitation.new
    i.host_id = u2.id
    i.invitee_id = 1
    i.status = 'pending'
    i.event_id = e.id
    i.save
end