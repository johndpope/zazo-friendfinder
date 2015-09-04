source 'https://rubygems.org'

gem 'rails'
gem 'pg'

gem 'faraday_middleware'
gem 'faraday-digestauth'
gem 'whenever', require: false

gem 'figaro', github: 'asux/figaro', branch: 'feature/eb-set-command'
gem 'puma'
gem 'rollbar'
gem 'newrelic_rpm'
gem 'remote_syslog_logger'
gem 'foreman'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard'
  gem 'guard-bundler', require: false
  gem 'guard-pow', require: false
  gem 'guard-rspec', require: false
  gem 'guard-migrate'
  gem 'guard-rubocop'
  gem 'terminal-notifier-guard'
  gem 'quiet_assets'
end

group :development, :test do
  gem 'pry-rescue'
  gem 'pry-remote'
  gem 'pry-rails'
  gem 'pry-byebug', '= 1.3.3'
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'rspec-collection_matchers'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'timecop'
  gem 'webmock'
  gem 'vcr'
  gem 'simplecov', require: false
end
