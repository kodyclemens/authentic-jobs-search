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
    # Comment out line 14 to test CLI functionality without using the API
    Job.create_jobs
    clear_terminal
    puts Rainbow('Jobs successfully collected.').green.bright
    menu
  end

  def self.menu
    puts '1. Search jobs by location'
    puts '2. Exit'
    print 'Please choose an option using a number: '
    @input = gets.chomp.to_i
    run_selection(@input) if validate_menu_input(@input) == true
  end

  def self.validate_menu_input(_input)
    if @input == 1 || @input == 2
      true
    else
      puts Rainbow('Invalid selection! Please try again.').red.bright
      menu
    end
  end

  def self.run_selection(input)
    case input
    when 1
      print "Please enter a location: "
      search_term = gets.chomp.to_s
      Job.search_by_location(search_term)
    when 2
      exit
    end
  end

  def self.clear_terminal
    system 'clear' # TODO: Ensure terminal clears cross-platform (check if UNIX or Win platform)
  end
end

CLI.run
