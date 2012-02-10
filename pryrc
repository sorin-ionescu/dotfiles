# ------------------------------------------------------------------------------
#          FILE:  .pryrc
#   DESCRIPTION:  IRB configuration file
#        AUTHOR:  Sorin Ionescu <sorin.ionescu@gmail.com>
#       VERSION:  1.0.0
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# General
# ------------------------------------------------------------------------------
Pry.editor = ENV['EDITOR'] || 'vi'

# Load the Rails configuration if Pry is running as a rails console.
load File.dirname(__FILE__) + '/.railsrc' if defined?(Rails) && Rails.env


# ------------------------------------------------------------------------------
# Prompt
# ------------------------------------------------------------------------------
# Show the Ruby version (useful for RVM).
Pry.prompt = [
  lambda { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " },
  lambda { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }
]


# ------------------------------------------------------------------------------
# Syntax Highlighting
# ------------------------------------------------------------------------------
CodeRay.scan("example", :ruby).term

# https://github.com/rubychan/coderay/blob/master/lib/coderay/encoders/terminal.rb
TOKEN_COLORS = {
  :attribute_name => '33',
  :attribute_value => '31',
  :binary => '1;35',
  :char => {
    :self => '36', :delimiter => '34'
  },
  :class => '1;35',
  :class_variable => '36',
  :color => '32',
  :comment => '37',
  :complex => '34',
  :constant => ['34', '4'],
  :decoration => '35',
  :definition => '1;32',
  :directive => ['32', '4'],
  :doc => '46',
  :doctype => '1;30',
  :doc_string => ['31', '4'],
  :entity => '33',
  :error => ['1;33', '41'],
  :exception => '1;31',
  :float => '1;35',
  :function => '1;34',
  :global_variable => '42',
  :hex => '1;36',
  :include => '33',
  :integer => '1;34',
  :key => '35',
  :label => '1;15',
  :local_variable => '33',
  :octal => '1;35',
  :operator_name => '1;29',
  :predefined_constant => '1;36',
  :predefined_type => '1;30',
  :predefined => ['4', '1;34'],
  :preprocessor => '36',
  :pseudo_class => '34',
  :regexp => {
    :self => '31',
    :content => '31',
    :delimiter => '1;29',
    :modifier => '35',
    :function => '1;29'
  },
  :reserved => '1;31',
  :shell => {
    :self => '42',
    :content => '1;29',
    :delimiter => '37',
  },
  :string => {
    :self => '36',
    :modifier => '1;32',
    :escape => '1;36',
    :delimiter => '1;32',
  },
  :symbol => '1;31',
  :tag => '34',
  :type => '1;34',
  :value => '36',
  :variable => '34',
  :insert => '42',
  :delete => '41',
  :change => '44',
  :head => '45'
}

module CodeRay
  module Encoders
    class Term < Encoder
      # Override old colors.
      TOKEN_COLORS.each_pair do |key, value|
        TOKEN_COLORS[key] = value
      end
    end
  end
end


# ------------------------------------------------------------------------------
# Listing
# ------------------------------------------------------------------------------
Pry.config.ls.separator = "\n"
Pry.config.ls.heading_color = :magenta
Pry.config.ls.public_method_color = :green
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.private_method_color = :bright_black


# ------------------------------------------------------------------------------
# Plugins
# ------------------------------------------------------------------------------
begin
  require 'awesome_print'
  # Enables Awesome Print and auto paging for all Pry output.
  Pry.config.print = lambda do |output, value|
    Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output)
  end

  # Disable auto paging.
  # Pry.config.print = lambda do |output, value|
  #  output.puts value.ai
  # end
rescue LoadError => err
  puts "Awesome Print is missing, please install it:"
  puts "  gem install awesome_print"
end


# ------------------------------------------------------------------------------
# Commands
# ------------------------------------------------------------------------------
# https://gist.github.com/1297510
default_command_set = Pry::CommandSet.new do
  command "copy", "Copy argument to the clip-board" do |str|
     IO.popen('pbcopy', 'w') { |f| f << str.to_s }
  end

  command "clear" do
    system 'clear'
    if ENV['RAILS_ENV']
      output.puts "Rails Environment: " + ENV['RAILS_ENV']
    end
  end

  command "sql", "Send SQL over ActiveRecord." do |query|
    if ENV['RAILS_ENV'] || defined?(Rails)
      pp ActiveRecord::Base.connection.select_all(query)
    else
      pp "No rails env defined"
    end
  end

  command "caller_method" do |depth|
    depth = depth.to_i || 1
    if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(depth+1).first
      file = Regexp.last_match[1]
      line = Regexp.last_match[2].to_i
      method = Regexp.last_match[3]
      output.puts [file, line, method]
    end
  end
end

Pry.config.commands.import default_command_set


# ------------------------------------------------------------------------------
# Extensions
# ------------------------------------------------------------------------------
# Generate populated arrays and hashes.
# https://gist.github.com/807492
class Array
  def self.toy(n=10, &block)
    block_given? ? Array.new(n, &block) : Array.new(n) {|i| i + 1}
  end
end

class Hash
  def self.toy(n=10)
    Hash[Array.toy(n).zip(Array.toy(n) {|c| (96 + ( c + 1)).chr})]
  end
end

