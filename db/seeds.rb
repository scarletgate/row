# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  [
    {
      email: 'aaa@test.test',
      name: 'テストユーザー１',
      password: 'password',
      is_deleted: 'false',
    },
    {
      email: 'bbb@test.test',
      name: 'テストユーザー２',
      password: 'password',
      is_deleted: 'false',
    },
    {
      email: 'ccc@test.test',
      name: 'テストユーザー３',
      password: 'password',
      is_deleted: 'false',
    },
    {
      email: 'ddd@test.test',
      name: 'テストユーザー４テストユーザー４',
      password: 'password',
      is_deleted: 'false',
    }
  ]

)