require "open-uri"
require "pry"
require_relative "Job.rb"

class JobAPI
  @@api = File.open("../api.txt", "r").read
  @@base_url = "https://authenticjobs.com/api/?api_key=#{@@api}&method=aj.jobs.search&format=json"

  def self.get_all_jobs_by_state(state)
    url = "#{@@base_url}&location=#{state}"
    unparsed_jobs = open(url).read
    parsed_jobs = JSON.parse(unparsed_jobs)
    return parsed_jobs
  end

  def self.create_jobs(parsed_jobs_hash_json)
    id = ""
    title = ""
    location = ""
    perks = ""
    post_date = ""
    apply_url = ""

    parsed_jobs_hash_json["listings"]["listing"].each do |job_attr|
      id = job_attr["id"]
      title = job_attr["title"]
      perks = job_attr["perks"]
      location = job_attr["company"]["location"]["name"]
      post_date = job_attr["post_date"]
      apply_url = job_attr["url"]
      Job.new(id, title, location, perks, post_date, apply_url)
    end
  end
end

JobAPI.create_jobs(JobAPI.get_all_jobs_by_state("New York"))
