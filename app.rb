require('sinatra')
require('sinatra/reloader')
require('pry')
require('pg')
require('./lib/volunteer')
require('./lib/project')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'volunteer_tracker_test', :user => 'tyates907', :host =>'localhost', :password => 'password'})

get('/') do
  redirect to('/home')
end
get('/home') do
  @projects = Project.all
  erb(:home)
end

post('/home') do
  project = Project.new(params)
  project.save
  redirect to ('/home')
end

get('/home/:id') do
  @project = Project.find(params[:id].to_i)
  erb(:project)
end

get('/home/:id/edit') do
  @project = Project.find(params[:id].to_i)
  erb(:project_edit)
end

patch('/home/:id/edit') do
  @project = Project.find(params[:id].to_i)
  @project.update(params)
  redirect to("/home/#{params[:id]}")
end
