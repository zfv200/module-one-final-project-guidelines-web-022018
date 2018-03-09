require 'bundler'
Bundler.require


old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/weather.db')
require_all 'lib'
require_all 'app/models'
