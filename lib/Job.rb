require_relative "JobAPI.rb"
require "JSON"
require "pry"

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

  def self.create_jobs
    id = ""
    title = ""
    location = "N/A"
    perks = ""
    post_date = ""
    apply_url = ""

    parsed_jobs_hash_json = JobAPI.get_all_jobs

    parsed_jobs_hash_json["listings"]["listing"].each do |job_attr|
      id = job_attr["id"]
      title = job_attr["title"]
      perks = job_attr["perks"]
      # Check to ensure the hash includes a location key. Not all jobs within our hash contain a location.
      if job_attr["company"]["location"]
        location = job_attr["company"]["location"]["name"]
      end
      post_date = job_attr["post_date"]
      apply_url = job_attr["apply_url"]
      self.new(id, title, location, perks, post_date, apply_url)
    end
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

# Testing functionality. Binding cannot be the last line.
Job.create_jobs
binding.pry
Job.search_by_location("New York")
binding.pry
puts "Please ignore"
