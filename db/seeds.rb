# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require_relative "seed_location"

JobType.find_or_create_by(:id => 0, :name => "quick")
JobType.find_or_create_by(:id => 1, :name => "stable")
JobType.find_or_create_by(:id => 2, :name => "intern")
JobType.find_or_create_by(:id => 3, :name => "project")

EmploymentType.find_or_create_by(:name => "fulltime")
EmploymentType.find_or_create_by(:name => "parttime")