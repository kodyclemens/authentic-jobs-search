require "open-uri"
require "pry"
require_relative "Job.rb"

class JobAPI
  @@api = File.open("../api.txt", "r").read
  @@base_url = "https://authenticjobs.com/api/?api_key=#{@@api}&method=aj.jobs.search&format=json&perpage=100"

  def self.get_all_jobs
    url = "#{@@base_url}"
    unparsed_jobs = open(url).read
    parsed_jobs = JSON.parse(unparsed_jobs)
    return parsed_jobs
  end

  def self.create_jobs(parsed_jobs_hash_json)
    id = ""
    title = ""
    location = "N/A"
    perks = ""
    post_date = ""
    apply_url = ""

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
      Job.new(id, title, location, perks, post_date, apply_url)
    end
  end
end

# Testing functionality. Binding cannot be the last line.
JobAPI.create_jobs(JobAPI.get_all_jobs)
binding.pry
Job.search_by_location("New York")
binding.pry
puts "Please ignore"