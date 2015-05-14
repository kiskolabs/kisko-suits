require "open3"
require "fileutils"
working_dir = File.dirname(__FILE__)

good_config = "#{working_dir}/data/preso.md.suits"
bad_config = "#{working_dir}/data/fail.md.suits"
good_output = "#{working_dir}/data/preso.md"
proper_output = "#{working_dir}/data/preso.md_proper"

ksuits_out, ksuits_err, ksuits_process = Open3.capture3("kisko-suits some_invalid_file")

unless ksuits_err =~ /Usage:/
  fail "Failed 'When suits can't find the file something bad happens'"
end


ksuits_out, ksuits_err, ksuits_process = Open3.capture3("kisko-suits #{good_config}")

unless FileUtils.compare_file(good_output, proper_output)
  fail "Failed 'When suits uses complex config'"
end
File.delete(good_output)


ksuits_out, ksuits_err, ksuits_process = Open3.capture3("kisko-suits #{bad_config}")

unless ksuits_err =~ /not found/
  fail "Failed 'When suits can't find the file in config something bad happens'"
end

puts "Tests pass, yay!"
