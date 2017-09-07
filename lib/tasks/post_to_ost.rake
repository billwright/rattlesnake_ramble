namespace :post_entries do
  desc 'Posts all 2017 race_entry and related racer data to OpenSplitTime.org'
  task to_ost_for_2017: :environment do
    Rake::Task['post_entries:to_ost'].invoke('rattlesnake-ramble-trail-race-on-2017-09-09', '2017-rattlesnake-ramble')
    Rake::Task['post_entries:to_ost'].invoke('rattlesnake-ramble-kids-race-on-2017-09-09', '2017-rattlesnake-ramble-kids-race')
  end


  desc 'Posts race_entry data from a specified race_edition to a specified opensplittime race_edition'
  task :to_ost, [:race_edition_id, :ost_event_id] => :environment do |_, args|
    start_time = Time.current
    race_edition_id = args[:race_edition_id]
    ost_event_id = args[:ost_event_id]

    puts 'Authenticating with OpenSplitTime'
    response = OST::GetToken.perform

    if response.is_a?(String)
      puts 'Authenticated'
    else
      abort("Aborted: Authentication failed with status #{response.code}\n" +
                "Headers: #{JSON.parse(response.headers)}\n" +
                "Body: #{JSON.parse(response.body)}")
    end

    token = response

    begin
      race_edition = RaceEdition.where(id: race_edition_id).or(RaceEdition.where(slug: race_edition_id)).eager_load(race_entries: :racer).first
    rescue ActiveRecord::RecordNotFound
      abort("Aborted: Race edition id #{race_edition_id} not found") unless race_edition
    end
    puts "Located race_edition: #{race_edition.name}"

    puts "Posting data to opensplittime.org event #{ost_event_id}"
    ost_response = OST::PostEntries.perform(race_edition: race_edition, ost_event_id: ost_event_id, token: token)
    abort('Aborted: No response received from opensplittime.org') unless ost_response.present?

    response_body = JSON.parse(ost_response.body)
    puts response_body

    if ost_response.code == 201
      puts "Posted #{response_body['data'].size} entries"
    else
      puts 'Request failed'
    end

    elapsed_time = (Time.current - start_time).round(2)
    puts "\nFinished post_entries:to_ost for race_edition: #{race_edition.name} to opensplittime event #{ost_event_id} in #{elapsed_time} seconds"
  end
end
