class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.first(5)
  end

  def self.dinghy
    where('length < ?', '20')
  end

  def self.ship
    where('length >= ?', '20')
  end

  def self.last_three_alphabetically
    order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(captain: nil)
  end

  def self.sailboats
    includes(:classifications).where(:classifications => {:name => "Sailboat"})
  end

  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("count(boat_id) = 3")
  end

  def self.longest
    order(length: :desc).first
  end

end
