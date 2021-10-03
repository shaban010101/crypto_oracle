# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'sinatra'

group :test do
  gem 'rack-test'
  gem 'rspec'
  gem 'webmock'
end

group :development, :test do
  gem 'pry-byebug'
end

gem 'activemodel', '~> 6.1.4'