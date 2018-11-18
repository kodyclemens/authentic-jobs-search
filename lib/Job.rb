require_relative 'JobAPI'
require 'pry'
require 'rainbow'

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
    id = 1
    title = ''
    location = 'N/A'
    perks = ''
    post_date = ''
    apply_url = ''

    parsed_jobs_hash_json = JobAPI.get_all_jobs

    parsed_jobs_hash_json['listings']['listing'].each do |job_attr|
      title = job_attr['title']
      perks = job_attr['perks']
      # Check to ensure the hash includes a location key. Not all jobs within our hash contain a location.
      if job_attr['company']['location']
        location = job_attr['company']['location']['name']
      end
      post_date = job_attr['post_date']
      apply_url = job_attr['apply_url']
      new(id, title, location, perks, post_date, apply_url)
      id += 1
    end
  end

  def self.search(type, term)
    CLI.clear_terminal
    selected_jobs = find_jobs(type, term)
    if selected_jobs.count > 0
      output_jobs(selected_jobs, term)
    else
      puts Rainbow("No jobs were found for search term \"#{term}\".").red.bright
      CLI.menu
    end
  end

  def self.output_jobs(jobs, search_term)
    blank_line = ''
    seperator = '-----'

    jobs.each do |job|
      puts job[0]
      puts blank_line
      puts job[1]
      puts blank_line
      puts seperator
      puts blank_line
      sleep(0.5)
    end
    puts Rainbow("#{jobs.count} job(s) found for search term \"#{search_term}\":").green.bright
  end

  def self.find_jobs(type, search_term)
    selected_jobs = []
    case type
    when 'location'
      @@all.each do |job_obj|
        if job_obj.location.include?(search_term)
          selected_jobs << ["#{job_obj.id}. #{job_obj.title} located in #{job_obj.location}.", "Apply at: #{job_obj.apply_url}"]
        end
      end
    end
    selected_jobs
  end
end
