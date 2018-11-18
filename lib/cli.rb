require_relative 'Job'
require 'rainbow'
require 'pry'

class CLI
  attr_accessor :input

  def self.run
    puts Rainbow('Authentic Jobs Search').green.bright
    puts Rainbow('Search and view details about jobs posted to authenticjobs.com')
    puts '-----'
    puts Rainbow('Please standby while job postings are collected...').yellow.bright
    Job.create_jobs
    # TODO: Ensure terminal clears cross-platform (check if UNIX or Win platform)
    system 'clear'
    puts Rainbow('Jobs successfully collected.').green.bright
    menu
  end

  def self.menu
    puts 'Please make a selection by entering a number:'
    puts '1. Search jobs by location'
    puts '2. Exit'
    @input = gets.chomp.to_i
    run_selection(@input) if validate_input(@input) == true
  end

  def self.validate_input(_input)
    if @input == 1 || @input == 2
      true
    else
      puts Rainbow('Invalid selection! Please try again.').red.bright
      menu
    end
  end

  def self.run_selection(input)
    if validate_input(input) == true
      case input
      when 1
        # Testing functionality of Job class method
        Job.search_by_location('NY')
      when 2
        exit
      end
    end
  end
end

CLI.run
