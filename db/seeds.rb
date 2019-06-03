# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new(:last_name => '君田',
                :first_name => '祥一',
                :email => 'kimi.syou.koma@gmail.com',
                :admin => true,
                :password => 'kimikimi123')

user.save!
