require 'rake'
require 'fileutils'

# ----- Versions ----- #
global_node_version = '9.3.0'

# ----- Installation Order ----- #
current_step = 0

installation_order = [
  'generate_gitconfig_from_template',
  'install_symlinks',
  'install_homebrew',
  'install_cask',
  'install_apple_store_apps',
  'install_global_node',
  'install_npm_packages',
  'install_osx_settings',
  'install_cleanup'
]

# ====================================
#   Installation Start
# ====================================
desc "Install our dotfiles into your new laptop."
task :install do
  puts
  puts "#{colorize("                        ===                         ", "blue")}"
  puts "#{colorize("                       (o o)                        ", "blue")}"
  puts "#{colorize("===================ooO--(_)--Ooo====================", "blue")}"
  puts "#{colorize("          Dotfiles Installation (v1.0.0)            ", "blue")}"
  puts "#{colorize("                  ready to go?                      ", "blue")}"
  puts "#{colorize("              --> Type 'start' <--                  ", "blue")}"
  puts "#{colorize("====================================================", "blue")}"

  run installation_order[current_step] if response?('start')
end

# ====================================
#   Generate a gitconfig
# ====================================
desc "Generate a gitconfig file from the template based on user input"
task :generate_gitconfig_from_template, :run do |task, args|
  current_step = current_step + 1
  gitconfig_name = "#{ENV["PWD"]}/git/gitconfig.symlink"
  exists = false
  skip = false
  regenerate = false

  if File.exists?(gitconfig_name)
    exists = true
    message 'A gitconfig file already exists, what do you want to do? [s]kip, [r]egenerate'
    case STDIN.gets.chomp
    when 's' then skip = true
    when 'r' then regenerate = true
    end
  end

  if not exists or regenerate
    repl = {}
    message 'Generating gitconfig'
    print("Your Name: "); STDOUT.flush; repl['__USER_NAME__'] = STDIN.gets.chomp
    print("Your Email: "); STDOUT.flush; repl['__USER_EMAIL__'] = STDIN.gets.chomp
    temp = IO.read("#{ENV["PWD"]}/git/gitconfig.template")
    repl.each { |k,v| temp.gsub!(k,v) }
    File.new(gitconfig_name, File::WRONLY|File::TRUNC|File::CREAT).puts temp
    success 'Gitconfig was created successfully'
  else
    message 'Skipping generation of gitconfig'
  end
  run installation_order[current_step] unless args[:run] == 'single'
end

# ====================================
#   Install Symlinks
# ====================================
desc "Hook our dotfiles into system-standard positions."
task :install_symlinks, :run do |task, args|
  current_step = current_step + 1

  prompt 'symlinks'

  if response?('y')
    message 'Symlinking files...'

    symlinking_files

    run installation_order[current_step] unless args[:run] == 'single'
  end
end

# ====================================
#   Install Homebrew & Packages
# ====================================
desc "Install Homebrew & Homebrew packages"
task :install_homebrew, :run do |task, args|
  current_step = current_step + 1

  prompt 'Homebrew Packages'

  if response?('y')
    message 'Installing Homebrew & Homebrew Packages...There may be some warnings.'

    system 'bash homebrew/install.sh'

    run installation_order[current_step] unless args[:run] == 'single'
  end
end

# ====================================
#   Install Global Node
# ====================================
desc "Install node via NVM"
task :install_global_node, :run do |task, args|
  current_step = current_step + 1

  nvm_directory = "#{ENV["HOME"]}/.nvm"

  prompt 'NVM'

  if response?('y')
    message "Installing Node #{ global_node_version }..."

    if not File.exists?(nvm_directory)
      running %{ git clone https://github.com/creationix/nvm.git ~/.nvm && cd ~/.nvm && git checkout `git describe --abbrev=0 --tags`}
      running %{ cd / && . ~/.nvm/nvm.sh &&  nvm install '#{ global_node_version }'}
      running %{ . ~/.nvm/nvm.sh && nvm alias default '#{ global_node_version }' }

      run installation_order[current_step] unless args[:run] == 'single'
    end

    puts "NVM already installed !"

    run installation_order[current_step] unless args[:run] == 'single'
  end
end

# ====================================
#   Install NPM Packages
# ====================================
desc "Install global NPM Packages"
task :install_npm_packages, :run do |task, args|
  current_step = current_step + 1

  prompt 'NPM Packages'

  if response?('y')
    message 'Installing NPM Packages...'

    system 'bash npm/install.sh'

    run installation_order[current_step] unless args[:run] == 'single'
  end
end

# ====================================
#   Install OS X Settings
# ====================================
desc "Install OS X Settings"
task :install_osx_settings, :run do |task, args|
  current_step = current_step + 1

  prompt 'OS X Settings'

  if response?('y')
    message 'Installing OS X Settings...'

    system 'bash osx/set-defaults.sh'

    run installation_order[current_step] unless args[:run] == 'single'
  end
end

# ====================================
#   Install Cask
# ====================================
desc "Install Cask & Applications"
task :install_cask, :run do |task, args|
  current_step = current_step + 1

  prompt 'Cask & Applications'

  if response?('y')
    message 'Installing Cask & Applications...'

    system 'bash cask/install.sh'

    run installation_order[current_step] unless args[:run] == 'single'
  end
end

# ====================================
#   Install Apple Store Apps
# ====================================
desc "Install Apple Store Apps"
task :install_apple_store_apps, :run do |task, args|
  current_step = current_step + 1

  prompt 'Apple Store Apps'

  if response?('y')
    message 'Installing Apple Store Apps via mas'

    system 'bash mas/install.sh'

    run installation_order[current_step] unless args[:run] == 'single'
  end
end

# ====================================
#   Install Command Line Tools
# ====================================
desc "Install Command Line Tools"
task :install_command_line_tools, :run do |task, args|
  current_step = current_step + 1

  prompt 'Command Line Tools'

  if response?('y')
    message 'Installing Command Line Tools'

    system 'xcode-select --install'

    run installation_order[current_step] unless args[:run] == 'single'
  end
end

# ====================================
#   Install Cleanup
# ====================================

task :install_cleanup do
  system "source #{ ENV['HOME'] }/.bashrc"

  success_install_msg
end

# Prints out a message to the console
#
# == Parameters
#
# @param string [String] the string to print out
#
# == Usage
#
#   message 'This is a message to show.'
#
def message(string)
  puts
  puts "[#{colorize("--", "blue")}] #{ string }"
end

# Prints out a success message to the console
#
# == Parameters
#
# @param string [String] the string to print out
#
# == Usage
#
#   success 'This is a message to show.'
#
def success(string)
  puts
  puts "[#{colorize("OK", "green")}] #{ string }"
end

# Prints out a message prompt for the user
#
# == Parameters
#
# @param section [String] the section to ask about
#
# == Usage
#
#   prompt 'Command Line Tools'
#
def prompt(section)
  puts
  puts "#{colorize("---------------------------------------------", "blue")}"
  puts "#{colorize(" Ready to install #{ section }? [y|n]", "blue")}"
  puts "#{colorize("---------------------------------------------", "blue")}"
end

# Determines the user's response
#
# == Parameters
#
# @param value [String] the response that is expected
#
# == Usage
#
#   if response?('yes')
#     # ...
#   end
#
def response?(value)
  STDIN.gets.chomp == value ? true : false
end

# Runs a particular Rake task
#
# == Parameters
#
# @param task [String] the task to run
#
# == Usage
#
#   run 'install_homebrew'
#
def run(task)
  Rake::Task[task].invoke
end

# Determines if a symlink can be made
#
# == Parameters
#
# @param destination_path [String] the destination of the symlink
#
# == Usage
#
#   if can_symlink?(destination_path)
#     # ...
#   end
#
def can_symlink?(destination_path)
  File.exists?(destination_path) ? false : true
end


# Creates all of the specified symlinks
#
# == Usage
#
#   symlinks_files
#
def symlinking_files
  linkables = Dir.glob('*/**{.symlink}')

  skip_all = false
  overwrite_all = false
  backup_all = false

  linkables.each do |linkable|
    overwrite = false
    backup = false

    file = File.basename(linkable).split('.')[0...-1].join('.')
    source = "#{ENV["PWD"]}/#{linkable}"
    target = "#{ENV["HOME"]}/.#{file}"

    puts "======================#{file}=============================="
    puts "Source: #{source}"
    puts "Target: #{target}"

    if File.exists?(target) || File.symlink?(target)
      unless skip_all || overwrite_all || backup_all
        puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
          when 'o' then overwrite = true
          when 'b' then backup = true
          when 'O' then overwrite_all = true
          when 'B' then backup_all = true
          when 'S' then skip_all = true
        end
      end
      FileUtils.rm_rf(target) if overwrite || overwrite_all
      # run %{ mv HOME/.#{file}" "$HOME/.#{file}.backup } if backup || backup_all
      `mv "$HOME/.#{file}" "$HOME/.#{file}.backup"` if backup || backup_all
    end
    #run %{ ln -nfs "#{source}" "#{target}" }
    `ln -s "$PWD/#{linkable}" "#{target}"`
    puts "=========================================================="
    puts
  end
end

# Runs a bash command
#
# == Parameters
#
# @param cmd [String] the bash command to run
#
# == Usage
#
#   running 'npm install'
#
private
def running(cmd)
  puts "[Running ...] #{cmd}"
  `#{cmd}` unless ENV['DEBUG']
end

# Color Util
#
# == Usage
#
#   #{colorize("Your text", "color", "bgColor")
#
def colorize(text, color = "default", bgColor = "default")
    colors = {"default" => "38","black" => "30","red" => "31","green" => "32","brown" => "33", "blue" => "34", "purple" => "35",
     "cyan" => "36", "gray" => "37", "dark gray" => "1;30", "light red" => "1;31", "light green" => "1;32", "yellow" => "1;33",
      "light blue" => "1;34", "light purple" => "1;35", "light cyan" => "1;36", "white" => "1;37"}
    bgColors = {"default" => "0", "black" => "40", "red" => "41", "green" => "42", "brown" => "43", "blue" => "44",
     "purple" => "45", "cyan" => "46", "gray" => "47", "dark gray" => "100", "light red" => "101", "light green" => "102",
     "yellow" => "103", "light blue" => "104", "light purple" => "105", "light cyan" => "106", "white" => "107"}
    color_code = colors[color]
    bgColor_code = bgColors[bgColor]
    return "\033[#{bgColor_code};#{color_code}m#{text}\033[0m"
end

def success_install_msg()
  puts
  puts '   _____ _           _      __ __           |  |                         '
  puts '  |_   _| |_ ___ ___| |_   |  |  |___ _ _   |  |                         '
  puts "    | | |   | .'|   | '_|  |_   _| . | | |  |__|                         "
  puts '    |_| |_|_|__,|_|_|_,_|    |_| |___|___|  |__|                         '
  puts '                                                                         '
  puts ' Dofiles has been successfully created. Please restart your terminal     '
  puts '========================================================================='
end
