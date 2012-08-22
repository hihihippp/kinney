namespace :kinney do
  desc 'reindex models in elasticsearch'
  task :reindex => :environment do
    ['Clip', 'Person'].each do |klass|
      ENV['CLASS'] = 'Kinney::' + klass
      Rake::Task['tire:import'].execute
    end
  end

  desc 'create friendly_ids for models'
  task :friendly_id => :environment do
    [Kinney::Clip, Kinney::Person].each do |klass|
      klass.find_each(&:save)
    end
  end

end

