# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Guide.create([
  { title: 'Getting Started', path: 'getting_started.html.haml' },
  { title: 'Four Themes', path: 'four_themes.html.haml' },
  { title: 'Four Dantes', path: 'four_dantes.html.haml' },
  { title: 'Contemplative Reading Practice', path: 'contemplative_reading_practice.html.haml' },
  { title: 'Dante is for Everyone', path: 'dante_is_for_everyone.html.haml' }
])