namespace :kinney do
  desc 'reindex models in elasticsearch'
  task :reindex => :environment do
    ['Clip', 'Person'].each do |klass|
      ENV['CLASS'] = 'Kinney::' + klass
      Rake::Task['tire:import:model'].execute
    end
  end

  desc 'create friendly_ids for models'
  task :friendly_id => :environment do
    [Kinney::Clip, Kinney::Person, Kinney::Topic].each do |klass|
      puts klass.to_s
      klass.find_each(&:save)
    end
  end

end

