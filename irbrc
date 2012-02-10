# ------------------------------------------------------------------------------
#          FILE:  .irbrc
#   DESCRIPTION:  IRB configuration file
#        AUTHOR:  Sorin Ionescu <sorin.ionescu@gmail.com>
#       VERSION:  1.0.0
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# General Options
# ------------------------------------------------------------------------------

# Add all gems in the global gemset to the $LOAD_PATH; so, they can be used even
# in places like 'rails console'.
# https://github.com/carlhuda/bundler/issues/183#issuecomment-1149953
if defined?(::Bundler)
  global_gemset = ENV['GEM_PATH'].split(':').grep(/ruby.*@global/).first
  if global_gemset
    all_global_gem_paths = Dir.glob("#{global_gemset}/gems/*")
    all_global_gem_paths.each do |p|
      gem_path = "#{p}/lib"
      $LOAD_PATH << gem_path
    end
  end
end


# ------------------------------------------------------------------------------
# Improved Console
# ------------------------------------------------------------------------------

begin
  # Use Pry everywhere
  require "rubygems" unless defined? Gem
  require 'pry'
  Pry.start
  exit
rescue LoadError
end

