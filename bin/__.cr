
require "../src/surferhearts"
full_cmd = ARGV.map(&.strip).join(' ')

case
when full_cmd == "service run"
  # === {{CMD}} service run
  SurferHearts.service_run

else
  STDERR.puts "!!! Invalid command: #{full_cmd}"
  exit 1
end # case
