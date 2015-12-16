# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
scott = User.create!(email: "scottmries@gmail.com")
christian = User.create!(email: "christian@gmail.com")
carl = User.create!(email: "carl@carl.carl")

ShortenedUrl.destroy_all
short_a = ShortenedUrl.create_for_user_and_long_url!(scott, "http://google.com")
short_b = ShortenedUrl.create_for_user_and_long_url!(scott, "http://facebook.com")
short_c = ShortenedUrl.create_for_user_and_long_url!(christian, "http://google.com")
short_d = ShortenedUrl.create_for_user_and_long_url!(carl, "http://appacademy.io")
short_e = ShortenedUrl.create_for_user_and_long_url!(christian, "http://airbnb.com")

Visit.destroy_all
Visit.create!(short_url_id: short_a.id, user_id: scott.id)
Visit.create!(short_url_id: short_a.id, user_id: scott.id)
Visit.create!(short_url_id: short_a.id, user_id: scott.id)
Visit.create!(short_url_id: short_a.id, user_id: christian.id)
Visit.create!(short_url_id: short_a.id, user_id: carl.id)
Visit.create!(short_url_id: short_b.id, user_id: scott.id)
Visit.create!(short_url_id: short_c.id, user_id: carl.id)
Visit.create!(short_url_id: short_b.id, user_id: christian.id)
