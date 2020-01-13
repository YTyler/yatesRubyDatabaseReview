require "volunteer"
require "project"
require "rspec"
require "pry"
require "pg"
require "./credentials"

CREDENTIALS[:dbname] = 'volunteer_tracker_test'
DB = PG.connect(CREDENTIALS)

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM volunteers *;')
    DB.exec('DELETE FROM projects *;')
  end
end
