# frozen_string_literal: true

module DatabaseHelper
  def self.wipe_database
    TravellingSuggestions::App.DB.run('PRAGMA foreign_keys = OFF')
    TravellingSuggestions::Database::RegionOrm.map(&:destroy)
    TravellingSuggestions::Database::LocationOrm.map(&:destroy)
    TravellingSuggestions::App.DB.run('PRAGMA foreign_keys = ON')
  end
end