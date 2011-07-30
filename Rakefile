#------------------------------------------------------------------------------
#          FILE:  Rakefile
#   DESCRIPTION:  Installs and uninstalls dot files.
#        AUTHOR:  Sorin Ionescu <sorin.ionescu@gmail.com>
#       VERSION:  2.0.1
#------------------------------------------------------------------------------

require 'date'
require 'open3'
require 'fileutils'
require 'rubygems'
require 'rake'

class KeychainError < Exception; end
def error(text); STDERR.puts "Error: #{text}"; end
def info(text); STDOUT.puts text; end

RAW_FILE_EXTENSION = 'rrc'
RAW_FILE_EXTENSION_REGEX = /\.#{RAW_FILE_EXTENSION}$/
KEYCHAIN_GENERIC_PASSWORD_COMMAND = 'security find-generic-password -gl'
KEYCHAIN_INTERNET_PASSWORD_COMMAND = 'security find-internet-password -gl'
KEYCHAIN_REGEX = /\{\{\s+keychain\[['"]([^'"]*)['"]\]\.([^}]*)\s+\}\}/
ACCOUNT_REGEX = /"acct"<blob>=(?:0x([0-9A-F]+)\s*)?(?:"(.*)")?$/
PASSWORD_REGEX = /^password: (?:0x([0-9A-F]+)\s*)?(?:"(.*)")?$/
SCRIPT_PATH = File.split(File.expand_path(__FILE__))
SCRIPT_NAME = SCRIPT_PATH.last
CONFIG_DIR_PATH = SCRIPT_PATH.first
BACKUP_DIR_PATH = File.join(ENV['HOME'],
  ".dotfiles_backup", DateTime.now.strftime("%Y-%m-%d-%H-%M-%S"))
EXCLUDES = [
  SCRIPT_NAME,
  '_darcs',
  '_MTN',
  '.svn',
  '.bzr',
  '.hg',
  '.hgignore',
  '.hgtags',
  '.hgmodules',
  '.git',
  '.gitignore',
  '.gitmodules',
  'README.md',
  'terminal',
  /backup\/.*$/
]

# Renders a raw dot file.
#
# @param [String] contents the raw file data.
# @return [String] the rendered file data.
def render(contents)
  contents.gsub! KEYCHAIN_REGEX do
    label = $1
    field = $2
    retry_times = 2
    keychain_command = KEYCHAIN_INTERNET_PASSWORD_COMMAND
    begin
      stdin, stdout, stderr = Open3.popen3("#{keychain_command} '#{label}'")
      output = stdout.readlines.join + stderr.readlines.join
      [stdin, stdout, stderr].each { |stdio| stdio.close }
      if output =~ /The specified item could not be found in Keychain\./
        raise NameError
      end
      # The field value is stored in hexademical (one) or string (two).
      field_value = lambda do |one, two|
        return one.scan(/../).map { |tuple| tuple.hex.chr }.join unless one.nil?
        return two unless two.nil?
        return ""
      end
      case field
        when 'account'
          output[ACCOUNT_REGEX].gsub!(ACCOUNT_REGEX) { field_value[$1, $2] }
        when 'password'
          output[PASSWORD_REGEX].gsub!(PASSWORD_REGEX) { field_value[$1, $2] }
        else
          raise KeychainError,
            "Field '#{field}' of Keychain entry '#{label}' does not exist."
      end
    rescue NameError
      keychain_command = KEYCHAIN_GENERIC_PASSWORD_COMMAND
      retry_times -= 1
      if retry_times > 0
        retry
      else
        raise KeychainError,
          "Item '#{label}' could not be found in the Keychain\."
      end
    rescue IOError
      raise KeychainError,
        "Could not communicate with Keychain for item '#{label}'."
    end
  end
  return contents
end

# Moves an existing dot file into the backup directory.
#
# @param [String] from the file to backup.
# @param [String] to the backup destination.
def backup(from, to)
  return unless File.exists? from
  FileUtils.mkdir_p(File.dirname(to))
  File.rename(from, to)
end

# Returns whether a path is excluded from linking into the home directory.
#
# @param [String] path the path a to file or directory.
# @return [true, false] if true, the path is excluded; otherwise, it is not.
def excluded?(path)
  strings = EXCLUDES.select { |item| item.class == String }
  regexps = EXCLUDES.select { |item| item.class == Regexp }
  excluded = strings.include? path
  regexps.each do |pattern|
    excluded = true if path =~ pattern
  end
  return excluded
end

desc 'Render raw dot files.'
task :render do
  Dir["#{CONFIG_DIR_PATH}/**/*.#{RAW_FILE_EXTENSION}"].each do |source|
    target = source.gsub(RAW_FILE_EXTENSION_REGEX, '')
    next if excluded? source
    if File.file? source
      begin
        source_contents = File.read source
        source_contents = render(source_contents)
      rescue IOError
        error "Could not read raw file '#{source}'."
      rescue KeychainError => e
        error e.message
      end
      begin
        target_contents = File.exists?(target) ? File.read(target) : nil
        # Only overwrite the rendered dot file if the raw file has changed.
        if source_contents != target_contents
          File.open(target, 'w') do |file|
            info "Writing: #{target}"
            file.write source_contents
          end
        end
      rescue IOError
        error "Could not write file '#{target}'."
      end
    end
  end
end

desc 'Symlink dot files.'
task :symlink do
  Dir["#{CONFIG_DIR_PATH}/*"].each do |source|
    target_relative = source.gsub("#{CONFIG_DIR_PATH}/", '')
    target_backup = File.join(BACKUP_DIR_PATH, target_relative)
    target = File.join(ENV['HOME'], ".#{target_relative}")
    # Do not link if the source is a raw file, the target already exists and
    # is a symlink to the source.
    next if source =~ RAW_FILE_EXTENSION_REGEX \
      or excluded?(target_relative) \
      or (File.exists?(target) \
        and File.ftype(target) == 'link' \
        and File.identical?(source, target))
    info "Linking: #{target}"
    begin
      backup(target, target_backup)
    rescue IOError
      error "Could not backup '#{target}', will skip symlinking '#{source}'."
      next
    end
    begin
      File.symlink(source, target)
    rescue IOError
      error "Could not symlink '#{source}' to '#{target}'."
    end
  end
end

desc 'Unlink broken symlinks.'
task :clean do
  Dir["#{ENV['HOME']}/.*"].each do |item|
    if File.ftype(item) == 'link'
      unless File.exists? item
        info "Unlinking: #{item}"
        begin
          File.unlink(item)
        rescue IOError
          error "Could not unlink '#{item}'."
        end
      end
    end
  end
end

desc 'Initialize submodules.'
task :init do
  if File.exists? '.gitmodules'
    # Popen3 does not return the exit status code.
    # Echo it onto the last line of stderr.
    Open3.popen3(
      "git submodule update --init --recursive; echo $? 1>&2"
    ) do |stdin, stdout, stderr|
      thread_stdout = Thread.new do
        Thread.current.abort_on_exception = true
        while line = stdout.gets
          next if line !~ /^Cloning into .*\.{3}$/
          info line.gsub(/^Cloning into (.*)\.{3}$/, "Initializing: \\1")
        end
      end
      thread_stderr = Thread.new do
        Thread.current.abort_on_exception = true
        while line = stderr.gets
          if line =~ /Unable to checkout '[^']+' in submodule path '([^']+)'/
            error "Could not initialize submodule '#{$1}'."
          end
          if stderr.eof? and line.to_i != 0
            error "Could not initialize submodules."
          end
        end
      end
      begin
        thread_stdout.join
        thread_stderr.join
      rescue Exception => e
        error e.message if e.class == IOError
      end
    end
  end
end

desc 'Update submodules.'
task :update do
  if File.exists? '.gitmodules'
    # Popen3 does not return the exit status code.
    # Echo it onto the last line of stderr.
    Open3.popen3(
      "git submodule foreach git pull origin master; echo $? 1>&2"
    ) do |stdin, stdout, stderr|
      thread_stdout = Thread.new do
        while line = stdout.gets
          if line =~ /Entering '([^']+)'/
            info "Updating: #{$1}"
          end
        end
      end
      thread_stderr = Thread.new do
        while line = stderr.gets
          if line =~ /Stopping at '([^']+)'/
            error "Could not update submodule '#{$1}'."
          end
          if stderr.eof? and line.to_i != 0
            error "Could not update submodules."
          end
        end
      end
      begin
        thread_stdout.join
        thread_stderr.join
        Rake::Task[:make].invoke
      rescue Exception => e
        error e.message if e.class == IOError
      end
    end
  end
end

desc 'Make submodules.'
task :make do
  Dir["#{CONFIG_DIR_PATH}/**/Rakefile"].each do |rake_file|
    next if SCRIPT_PATH.join('/') == rake_file
    submodule = File.dirname rake_file
    submodule_relative = submodule.gsub("#{CONFIG_DIR_PATH}/", '')
    read, write = IO.pipe
    pid = fork do
      Dir.chdir submodule
      Rake::Task.clear
      load rake_file
      next unless Rake::Task.task_defined?(:make)
      info "Making: #{submodule_relative}"
      # Redirect stdout, stderr since make is noisy.
      stdout_old = STDOUT.clone
      stderr_old = STDERR.clone
      begin
        STDOUT.reopen write
        STDERR.reopen STDOUT
        read.close
        Rake::Task[:make].invoke
      rescue Exception => e
        STDOUT.reopen stdout_old
        STDERR.reopen stderr_old
        error e.message
      end
    end
    begin
      write.close
      read.each do |line|
        if read.eof? and line =~ /error:/i
          error "Could not make '#{submodule_relative}'."
        end
      end
    rescue IOError => e
      error e.message
    end
    Process.waitpid(pid)
  end
end

desc 'Uninstall dot files.'
task :uninstall do
  Dir["#{CONFIG_DIR_PATH}/*"].each do |source|
    target_relative = source.gsub("#{CONFIG_DIR_PATH}/", '')
    target = File.join(ENV['HOME'], ".#{target_relative}")
    next if source =~ RAW_FILE_EXTENSION_REGEX or excluded?(target_relative)
    # Uninstall only if the target exists, is a symlink, and points to source.
    if File.exists?(target) \
      and File.ftype(target) == 'link' \
      and File.identical?(source, target)
      info "Unlinking: #{target}"
      begin
        File.unlink(target)
      rescue IOError
        error "Could not unlink '#{target}'."
      end
    end
  end
end

desc 'Install dot files.'
task :install => [:init, :make, :clean, :render, :symlink] do
  info "Backup: #{BACKUP_DIR_PATH}" if File.exists? BACKUP_DIR_PATH
end

task :default => [:install]

