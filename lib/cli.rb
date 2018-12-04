class CLI
  @top_level_menu_options = [1, 2]
 
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

  def self.validate_menu_input(input)
    if @top_level_menu_options.include?(input)
      true
    else
      clear_terminal
      puts Rainbow('Invalid selection! Please try again.').red.bright
      menu
    end
  end

  def self.run_selection(input)
    case input
    when 1
      clear_terminal
      print 'Please enter a location: '
      search_term = gets.chomp.to_s
      Job.search('location', search_term)
      sub_menu
    when 2
      puts 'Goodbye.'
      exit
    end
  end

  def self.clear_terminal
    # Try to clear terminal using both methods - Unix (clear) and Windows (cls)
    system "clear" or system "cls"
  end

  def self.sub_menu
    print "Enter job ID or 'return' to go back to the main menu: "
    input = gets.chomp
    if input == 'return'
      clear_terminal
      menu
    else
      Job.job_details(input)
    end
  end
end

CLI.run
