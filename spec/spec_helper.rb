require "volunteer"
require "project"
require "rspec"
require "pry"
require "pg"

DB = PG.connect({:dbname => 'volunteer_tracker_test', :user => 'tyates907'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM volunteers *;')
    DB.exec('DELETE FROM projects *;')
  end
end
