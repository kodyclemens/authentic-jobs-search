require 'open-uri'

class JobAPI
  @@api = File.open('./api.txt', 'r').read
  @@base_url = "https://authenticjobs.com/api/?api_key=#{@@api}&method=aj.jobs.search&format=json&perpage=100"

  def self.get_all_jobs
    url = @@base_url.to_s
    unparsed_jobs = open(url).read
    parsed_jobs = JSON.parse(unparsed_jobs)
    parsed_jobs
  end
end
