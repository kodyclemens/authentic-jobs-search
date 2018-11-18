require_relative "Job"
require "pry"

class CLI
  def run
    puts "Authentic Jobs Search"
    puts "A CLI tool to search and view details about jobs posted to authenticjobs.com"
    puts "-----"
    puts "Please standby while we collect the job postings..."
    Job.create_jobs
    binding.pry
    puts "ignore"
  end
end
