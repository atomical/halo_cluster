require 'open-uri'

namespace :map do
  task import: :environment do
    MapImporter.seed
  end
end
