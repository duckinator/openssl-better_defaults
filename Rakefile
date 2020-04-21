# frozen-string-literal: true

require 'bundler/gem_tasks'
require 'github_changelog_generator/task'
require_relative 'lib/openssl/better_defaults/version'

GitHubChangelogGenerator::RakeTask.new :changelog do |config|
  config.user = 'duckinator'
  config.project = 'openssl-better_defaults'
  config.since_tag = '0.0.1'
  config.future_release = OpenSSL::BetterDefaults::VERSION
  config.token = File.read(
    File.join(Dir.home, '.config', 'github-changelog-generator', 'token.txt')
  ).strip
end
