class Volunteer
  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes.fetch(:name) || nil
    @id = attributes.fetch(:id, nil)
  end

  def ==(other_volunteer)
    self.name == other_volunteer.name
  end

end
