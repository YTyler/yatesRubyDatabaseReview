require('sinatra')
require('sinatra/reloader')
require('pry')
require('pg')
require('./lib/volunteer')
require('./lib/project')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'volunteer_tracker', :user => 'tyates907', :host =>'localhost', :password => 'password'})

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
  @volunteers = @project.get_volunteers
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

delete('/home/:id/delete') do
  @project = Project.find(params[:id].to_i)
  @project.delete
  redirect to("/home")
end

get('/home/:id/volunteer/:volunteer_id') do
  @project = Project.find(params[:id].to_i)
  @volunteer = Volunteer.find(params[:volunteer_id].to_i)
  erb(:volunteer)
end

post('/home/:id/volunteer') do
  @project = Project.find(params[:id].to_i)
  @volunteer = Volunteer.new(:name => params[:name], :project_id => params[:id])
  @volunteer.save
  redirect to("/home/#{params[:id]}")
end

patch('/home/:id/volunteer/:volunteer_id/edit') do
  @volunteer = Volunteer.find(params[:volunteer_id].to_i)
  @volunteer.update(params)
  redirect to("/home/#{params[:id]}/volunteer/#{params[:volunteer_id]}")
end

delete('/home/:id/volunteer/:volunteer_id/delete') do
  @volunteer = Volunteer.find(params[:volunteer_id].to_i)
  @volunteer.delete
  redirect to("/home/#{params[:id]}")
end
