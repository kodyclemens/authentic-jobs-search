class Job
  attr_reader :id, :title, :location, :perks, :post_date, :apply_url

  @@all = []
  @@jobs_found_by_search = []

  def initialize(id, title, location = nil, perks = 'N/A', post_date, apply_url)
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

  def self.create_jobs
    # Method called from CLI
    # Iterate through hash returned from JobAPI.get_all_jobs
    # Each job result in the hash will be used to create a new Job object
    id = 1
    title = ''
    perks = ''
    post_date = ''
    apply_url = ''
    location = 'N/A'
    
    parsed_jobs_hash_json = JobAPI.get_all_jobs
    
    parsed_jobs_hash_json['listings']['listing'].each do |job_attr|
      title = job_attr['title']
      perks = job_attr['perks']
      # Check to ensure the hash includes a location key.
      # Not all jobs within our hash contain a location.
      if job_attr['company']['location']
        location = job_attr['company']['location']['name']
      end

      post_date = job_attr['post_date']
      apply_url = job_attr['apply_url']
      new(id, title, location, perks, post_date, apply_url)
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
