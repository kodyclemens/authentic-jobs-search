class Job
  attr_reader :id, :title, :location, :perks, :post_date, :apply_url

  @@all = []

  def initialize(id, title, location = nil, perks, post_date, apply_url)
    @id = id
    @title = title
    @location = location
    @perks = perks
    @post_date = post_date
    @apply_url = apply_url
    @@all << self
  end

  def self.all
    @@all
  end

  def self.search_by_location(location)
    selected_jobs = []
    @@all.each do |job_obj|
      if job_obj.location.include?(location)
        selected_jobs << job_obj
      end
    end
    return selected_jobs
  end
end
