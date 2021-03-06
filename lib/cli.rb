class CLI
  @menu_options = [1, 2, 1337]
  @jobs_found_by_search = nil
 
  def self.run
    display_logo
    puts Rainbow('Please standby while job postings are collected...').cyan
    # Comment out line below to test CLI functionality without using the API
    Job.create_jobs
    clear_terminal
    puts Rainbow('Jobs successfully collected.').cyan
    menu
  end

  def self.menu
    puts '1. Search jobs by location'
    puts '2. Exit'
    print 'Please choose an option using a number: '
    @input = gets.chomp.to_i
    if @menu_options.include?(@input)
      run_selection(@input)
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
      jobs_found = Job.search(search_term)
      Job.jobs_found? ? short_description(jobs_found) : no_jobs_found
      sub_menu
    when 2
      quit
    when 1337
      binding.pry
    end
  end

  def self.sub_menu
    print Rainbow("Enter job ID, 'return' to search again or 'exit': ").cyan
    input = gets.chomp
    if input == 'return'
      Job.clear_search_returned_jobs
      clear_terminal
      menu
    elsif input == 'exit'
      quit
    else
      if Job.return_job_by_index(input) != nil && input.to_i > 0
        description(Job.return_job_by_index(input))
      else
        invalid_sub_menu_selection
      end
      sub_menu
    end
  end

  def self.short_description(jobs)
    puts Rainbow("#{jobs.count} jobs found!").cyan, ""
    jobs.each.with_index(1) do |job, index|
      puts "#{index}. #{job.title} located in #{job.location}.", ""
      sleep(0.5)
    end
  end

  def self.description(job_obj)
    puts
    puts Rainbow("#{job_obj.title}").underline
    puts "Job location: #{job_obj.location}"
    puts "Posted by employer: #{job_obj.post_date}"
    puts "Apply online at: #{job_obj.apply_url}", ""
  end

  def self.no_jobs_found
    clear_terminal
    puts Rainbow('No jobs found! Please try another search.').red.bright
    menu 
  end

  def self.invalid_sub_menu_selection
    puts Rainbow('Invalid job ID chosen! Please try again.').red.bright
  end

  def self.clear_terminal
    # Try to clear terminal using both methods - Unix (clear) and Windows (cls)
    system "clear" or system "cls"
  end

  def self.quit
    puts 'Goodbye'
    exit
  end

  def self.display_logo
    # ASCII from https://www.asciiart.eu/computers/computers
    flatiron = Rainbow("//").cyan
    puts Rainbow("
          ,---------------------------,
          |  /---------------------\\  |
          | |   #{flatiron}                  | |
          | |     Authentic         | |
          | |      Jobs             | |
          | |       Search          | |
          | |                       | |
          |  \\_____________________/  |
          |___________________________|
        ,---\\_____     []     _______/------,
      /         /______________\\           /|
    /___________________________________ /  | ___
    |                                   |   |    )
    |  _ _ _                 [-------]  |   |   (
    |  o o o                 [-------]  |  /    _)_
    |__________________________________ |/     /  /
    /-------------------------------------/|  ( )/
  /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/ /
/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/ /
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n").white
  end
end
