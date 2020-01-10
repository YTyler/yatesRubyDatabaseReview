class Volunteer
  attr_accessor :name, :id

  def initialize(attributes)
    @title = attributes.fetch(:name) || nil
    @id = attributes.fetch(:id, nil)
  end

  def ==(other_volunteer)
    self.name == other_volunteer.name
  end

end
