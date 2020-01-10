class Volunteer
  attr_accessor :title, :id

  def initialize(attributes)
    @title = attributes.fetch(:title) || nil
    @id = attributes.fetch(:id, nil)
  end

  def ==(other_volunteer)
    self.title == other_volunteer.title
  end

end
