module PositionMacros

  def create_position
    @position_attr = FactoryGirl.attributes_for(:position)
    @position = Position.create!(@position_attr)
    @position.organization = Organization.first
    @position.save
  end

  
end
