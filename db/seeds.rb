# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



User.destroy_all
BookingType.destroy_all

user = User.create!(
    booking_link: "salmandev",
    email: "salman@gmail.com",
    name: "salman",
    password: "112233",
    password_confirmation: "112233"
)

Booking_type1 = BookingType.create!(
    color: "#38bdf8",
    description: "15min testing",
    duration: 15,
    location: "zoom",
    name: "15mins",
    payment_requied: false,
    price: nil,
    user: user
)

Booking_type2 = BookingType.create!(
    color: "#fbbf24",
    description: "30min testing",
    duration: 30,
    location: "zoom",
    name: "30mins",
    payment_requied: false,
    price: nil,
    user: user
)

Booking_type3 = BookingType.create!(
    color: "#34d399",
    description: "1 hour testing",
    duration: 60,
    location: "zoom",
    name: "60mins",
    payment_requied: true,
    price: 125,
    user: user
)

puts "done"
