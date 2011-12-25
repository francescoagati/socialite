require 'rails/generators/active_record'

module Socialite
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)

    def install
      template "initializer.rb", "config/initializers/socialite.rb"
      copy_file "../../../../config/locales/en.yml", "config/locales/socialite.en.yml"
      route "mount Socialite::Engine => '/auth'"
      readme "README"
    end

    def self.next_migration_number(dirname)
      ActiveRecord::Generators::Base.next_migration_number(dirname)
    end
  end
end
