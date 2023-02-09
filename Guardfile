# vim: set syntax=ruby:

clearing :on

ignore %r{^node_modules/.*}, %r{^.*/test/fixtures/.*}

guard :shell do
  watch %r{^.*/.*_test\.rb} do |match|
    framework, test_file = match[0].split("/test/")
    n "Running #{framework} test: #{test_file}"
    output = %x{ #{framework}/bin/test #{framework}/test/#{test_file} }
    n output.lines[-2..].join
    output
  end
end


notification :terminal_notifier
