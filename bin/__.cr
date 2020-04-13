
require "../src/surferhearts"
full_cmd = ARGV.map(&.strip).join(' ')

case

when ARGV[0..1].join(' ') == "service run" && ARGV[2]? && ARGV[3]?
  SurferHearts.service_run(ARGV[2].to_i32, ARGV[3])

else
  STDERR.puts "!!! Invalid command: #{full_cmd}"
  exit 1
end # case
