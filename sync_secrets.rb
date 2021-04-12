#!/usr/bin/env ruby

require 'rubygems'
require 'commander/import'

# :name is optional, otherwise uses the basename of this executable
program :name, 'GitHub Sync Secrets'
program :version, '0.1.0'
program :description, 'Sync env file to GitHub secrets'

default_command :to_gh

command :to_gh do |c|
  c.syntax = 'sync_secrets [options]'
  c.description = 'sync local env file to GitHub'
  c.option '--file STRING', String, 'Env file'
  c.option '--repo STRING', String, 'GitHub repo'
  c.option '--prefix STRING', String, 'Adds a prefix to each environment variables (optional)'
  c.option '--print', 'Print GH commands'
  c.action do |args, options|
    options.default :file => '.env'
    options.default :prefix => ''
    secret_file_to_gh(options.file, options.repo, options.prefix, options.trace)
  end
end


def secret_file_to_gh(file, repo, prefix, print_command)
  File.foreach(file) do |line|
    line_wo_comments = line.chomp.strip.split("#").first
    next unless line_wo_comments
    next if line_wo_comments.strip.empty?
    
    secret_name, secret_value = line_wo_comments.split("=")
    prefixed_secret_name = "#{prefix}#{secret_name}"
    
    command = "gh secret set #{prefixed_secret_name} --body #{secret_value} -R #{repo}"
    p command if print_command
    system command
  end
end