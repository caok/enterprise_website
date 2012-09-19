#source 'https://rubygems.org'
source 'http://ruby.taobao.org/'

gem 'rails', '3.2.6'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'jquery-rails'
gem 'kaminari'
gem 'thin'
# Attachment
gem 'carrierwave'
gem 'mini_magick'
gem 'mime-types'
# Markdown
gem 'redcarpet'
gem "rails_autolink", ">= 1.0.4"
# authorization
gem 'devise'
gem 'cancan'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem "twitter-bootstrap-rails"
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

platforms :jruby do
  gem 'therubyrhino'
  gem 'jruby-openssl'
  gem 'activerecord-jdbcmysql-adapter'

  # 1.1.3 has a bug, ref: https://github.com/josh/ruby-coffee-script/issues/12
  #gem 'coffee-script-source', '1.1.2'
  group :development, :test do
  end

  group :production do
  end
end

platforms :ruby do
  gem 'therubyracer'
  gem 'mysql2'

  group :development, :test do
    # Deploy with Capistrano
    gem 'capistrano'
  end

  group :production do
  end
end

platforms :mingw do
  gem 'sqlite3'
  group :development, :test do
    # Deploy with Capistrano
    #gem 'capistrano'
  end

  group :production do
  end
end

group :development, :test do
  gem 'rspec-rails'
  gem 'pry'
  gem 'pry-nav'
  #gem 'nifty-generators', :git => 'git://github.com/wongyouth/nifty-generators.git'
  gem 'rb-notifu', :platforms => :mingw
  gem 'libnotify', :platforms => :ruby
end

group :test do
  # Pretty printed test output
  # gem 'turn', :require => false
  gem 'cucumber-rails', :require => false
  gem 'guard-cucumber'
  gem 'guard-spork'
  gem 'pickle'
  gem 'guard-rspec'
  gem 'spork-rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem "mocha"
end
