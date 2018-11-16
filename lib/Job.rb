class Job
  attr_reader :id, :title, :city, :state, :perks, :post_date, :apply_url

  @@all = []

  def initialize(id, title, location, perks, post_date, apply_url)
    @id = id
    @title = title
    @city = city
    @state = state
    @perks = perks
    @post_date = post_date
    @apply_url = apply_url
    @@all << self
  end

  def self.all
    @@all
  end
end
