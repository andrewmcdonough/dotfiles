# Load plugins (only those I whitelist)
Pry.config.should_load_plugins = false

# Shortcuts to make pry behave like byebug
if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

# Press enter repeats last command
Pry::Commands.command /^$/, "repeat last command" do
  _pry_.run_command Pry.history.to_a.last
end
