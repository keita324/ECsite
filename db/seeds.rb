# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
    email: "aaa@aaa",
    password: "aaaaaa"
)

Genre.create!(
    name: "ケーキ",
)

item = Item.create!(
    genre_id: "1",
    name: "いちごケーキ",
    introduction: "おいしい",
    price_tax_out: "1000",
    status: "true"
)

    item.image.attach(io: File.open(Rails.root.join('app/assets/images/itigo-cake.jpg')),filename: 'itigo-cake.jpg')

item = Item.create!(
    genre_id: "1",
    name: "チーズケーキ",
    introduction: "うまい",
    price_tax_out: "1000",
    status: "false"
)

    item.image.attach(io: File.open(Rails.root.join('app/assets/images/cheese-cake.jpg')),filename: 'cheese-cake.jpg')