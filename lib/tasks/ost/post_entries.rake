namespace :ost do
  desc 'Posts all 2017 race_entry and related racer data to OpenSplitTime.org'
  task post_entries_2017: :environment do
    editions = {'rattlesnake-ramble-trail-race-on-2017-09-09' => '2017-rattlesnake-ramble',
                'rattlesnake-ramble-kids-race-on-2017-09-09' => '2017-rattlesnake-ramble-kids-race'}

    editions.each do |race_edition_id, ost_event_id|
      Rake::Task['ost:post_entries'].invoke(race_edition_id, ost_event_id)
      Rake::Task['ost:post_entries'].reenable
    end
  end

  desc 'Posts all 2018 race_entry and related racer data to OpenSplitTime.org'
  task post_entries_2018: :environment do
    editions = {'rattlesnake-ramble-trail-race-even-year-on-2018-09-15' => '2018-rattlesnake-ramble',
                'rattlesnake-ramble-kids-race-on-2018-09-15' => '2018-rattlesnake-ramble-kids-run'}

    editions.each do |race_edition_id, ost_event_id|
      Rake::Task['ost:post_entries'].invoke(race_edition_id, ost_event_id)
      Rake::Task['ost:post_entries'].reenable
    end
  end

  desc 'Posts all 2019 race_entry and related racer data to OpenSplitTime.org'
  task post_entries_2019: :environment do
    editions = {'rattlesnake-ramble-trail-race-on-2019-09-14' => '2019-rattlesnake-ramble',
                'rattlesnake-ramble-kids-race-on-2019-09-14' => '2019-rattlesnake-ramble-kids-run'}

    editions.each do |race_edition_id, ost_event_id|
      Rake::Task['ost:post_entries'].invoke(race_edition_id, ost_event_id)
      Rake::Task['ost:post_entries'].reenable
    end
  end

  desc 'Posts all 2020 race_entry and related racer data to OpenSplitTime.org'
  task post_entries_2020: :environment do
    editions = {'rattlesnake-ramble-trail-race-on-2020-09-12' => '2020-rattlesnake-ramble',
                'rattlesnake-ramble-kids-race-on-2020-09-12' => '2020-rattlesnake-ramble-kids-run'}

    editions.each do |race_edition_id, ost_event_id|
      Rake::Task['ost:post_entries'].invoke(race_edition_id, ost_event_id)
      Rake::Task['ost:post_entries'].reenable
    end
  end


  desc 'Posts race_entry data from a specified race_edition to a specified opensplittime event'
  task :post_entries, [:race_edition_id, :ost_event_id] => :environment do |_, args|
    start_time = Time.current
    race_edition_id = args[:race_edition_id]
    ost_event_id = args[:ost_event_id]

    print 'Authenticating with OpenSplitTime...'
    auth_response = OST::GetToken.perform

    unless auth_response.successful?
      abort("Aborted: Authentication failed with status #{auth_response.code}\n" +
                "Headers: #{auth_response.headers}\n" +
                "Body: #{JSON.parse(auth_response.body)}")
    end

    puts 'authenticated'
    token = auth_response.token

    begin
      race_edition = RaceEdition.where(id: race_edition_id).or(RaceEdition.where(slug: race_edition_id)).eager_load(race_entries: :racer).first
    rescue ActiveRecord::RecordNotFound
      abort("Aborted: Race edition id #{race_edition_id} not found") unless race_edition
    end
    puts "Located race_edition: #{race_edition.name}"

    puts "Posting data to opensplittime.org event #{ost_event_id}"
    post_response = OST::PostEntries.perform(race_edition: race_edition, ost_event_id: ost_event_id, token: token)
    abort('Aborted: No response received from opensplittime.org') unless post_response.present?

    if post_response.successful?
      puts "Posted #{ActionController::Base.helpers.pluralize(post_response.data&.size, 'entry')}"
    else
      puts "Post failed: #{post_response.errors}"
    end

    elapsed_time = (Time.current - start_time).round(2)
    puts "Finished post_entries:to_ost for race_edition: #{race_edition_id} to opensplittime event #{ost_event_id} in #{elapsed_time} seconds\n\n"
  end
end
