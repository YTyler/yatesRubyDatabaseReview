class Project
  attr_accessor :title, :id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id, nil)
  end

  def ==(other_project)
    self.title == other_project.title
  end

  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.all
    returned_projects = DB.exec('SELECT * FROM projects')
    projects = []
    returned_projects.each do |project|
      title = project.fetch('title')
      id = project.fetch('id')
      projects.push(Project.new({:title => title, :id => id}))
    end
    projects
  end

  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
    title = project.fetch('title')
    id = project.fetch('id').to_i
    Project.new({:title => title, :id => id})
  end

  def update(attributes)
    @title = attributes.fetch(:title)
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id}")
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{id};")
  end

  def self.clear
    DB.exec("DELETE FROM projects *;")
  end

  def get_volunteers()
    returned_volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{@id};")
    volunteers = []
    returned_volunteers.each do |volunteer|
      name = volunteer.fetch('name')
      id = volunteer.fetch('id')
      volunteers.push(Volunteer.new({:name => name, :id => id, :project_id => @id}))
    end
    volunteers
  end

end
