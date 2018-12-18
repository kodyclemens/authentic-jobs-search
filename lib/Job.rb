class Job
  attr_accessor :id, :title, :location, :perks, :post_date, :apply_url

  @@all = []
  @@jobs_found_by_search = []

  def initialize(attributes)
    attributes.each { |key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_jobs
    # Method called from CLI
    # Iterate through hash returned from JobAPI.get_all_jobs
    # Each job result in the hash will be used to create a new Job object
    id = 1
    
    parsed_jobs_hash_json = JobAPI.get_all_jobs
    
    parsed_jobs_hash_json['listings']['listing'].each do |job_attr|
      listing = {}
      listing["title"] = job_attr['title']
      listing["perks"] = job_attr['perks']
      listing["post_date"] = job_attr['post_date']
      listing["apply_url"] = job_attr['apply_url']
      listing["id"] = id

      # Check to ensure the hash includes a location key.
      # Not all jobs within our hash contain a location.
      if job_attr['company']['location']
        listing["location"] = job_attr['company']['location']['name']
      else
        listing["location"] = 'Not provided'
      end

      new(listing)
      id += 1
    end
  end

  def self.search(search_term)
    clear_search_returned_jobs

    @@jobs_found_by_search = @@all.select do |job|
      job.location.include?(search_term)
    end
  end

  def self.jobs_found_by_search
    @@jobs_found_by_search
  end

  def self.clear_search_returned_jobs
    @@jobs_found_by_search.clear
  end

  def self.return_job_by_index(user_input)
    index = user_input.to_i - 1
    @@jobs_found_by_search[index]
  end

  def self.jobs_found?
    if @@jobs_found_by_search == []
      false
    else
      true
    end
  end
end
