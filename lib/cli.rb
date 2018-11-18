require_relative "Job"
require "pry"

class CLI
  attr_accessor :input

  def self.run
    puts "Authentic Jobs Search"
    puts "A CLI tool to search and view details about jobs posted to authenticjobs.com"
    puts "-----"
    puts "Please standby while we collect the job postings..."
    Job.create_jobs
    self.menu
  end

  def self.menu
    puts "Please make a selection by entering a number:"
    puts "1. Search jobs by location"
    puts "2. Exit"
    @input = gets.chomp.to_i
    validate_input(@input)
    run_selection(@input)
  end

  def self.validate_input(input)
    if @input.is_a? Integer
      return true
    else
      puts "Invalid selection!"
      menu
    end
  end

  def self.run_selection(input)
    if validate_input(input) == true
      case input
      when 1
        # Testing functionality of Job class method
        Job.search_by_location("NY")
      when 2
        exit
      end
    end
  end
end

CLI.run
