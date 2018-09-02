Resque.logger = Logger.new(Rails.root.join('log', "#{Rails.env}_resque.log"))
Resque.schedule = YAML.load_file Rails.root.join('config', 'resque_schedule.yml')