class Volunteer
  attr_accessor :name, :id, :project_id

  def initialize(attributes)
    @name = attributes.fetch(:name) || nil
    @id = attributes.fetch(:id, nil)
    @project_id = attributes.fetch(:project_id, nil)
  end

  def ==(other_volunteer)
    self.name == other_volunteer.name
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.all
    returned_volunteers = DB.exec('SELECT * FROM volunteers;')
    volunteers = []
    returned_volunteers.each() do |volunteer|
      name = volunteer.fetch('name')
      id = volunteer.fetch('id').to_i
      project_id = volunteer.fetch('project_id')
      volunteers.push(Volunteer.new({:name => name, :id => id, :project_id => project_id}))
    end
    volunteers
  end

  def self.find(id)
    volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
    name = volunteer.fetch("name")
    id = volunteer.fetch("id").to_i
    project_id = volunteer.fetch("project_id")
    Volunteer.new({:name => name, :id => id, :project_id => project_id})
  end

  def update(attributes)
    @name = attributes.fetch(:name)
    DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id}")
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{id};")
  end

  def self.clear
    DB.exec("DELETE FROM volunteers *;")
  end

end
