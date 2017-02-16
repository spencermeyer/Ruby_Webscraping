# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
run=Run.create(run_identifier: 'foobarrun')
result=Result.create(pos: '23', parkrunner: 'Joe Bloggs', time: '50:34', age_cat: 'SW30-34', gender: 'F', gender_pos: '162', club: 'nearly running', note: 'seed data', total: '17', run_id: run.id, age_grade_position: 370, age_cat_posiiton: 370, athlete_number: nile )