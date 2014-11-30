# A sample Guardfile
# More info at https://github.com/guard/guard#readme

dirs = %w( bin config lib spec )
everything = dirs + ['*file']

guard :yard do
  watch(%r{bin/.+\.rb$})
  watch(%r{lib/.+\.rb$})
end

guard :rspec, spec_paths: ['spec'], all_on_start: true, all_after_pass: true,
              failed_mode: :keep, run_all: {cmd: 'rspec --format progress'}  do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { 'spec' }
end

guard :rubocop, cli: everything do
  dirs.each do |dir|
    watch( %r{#{dir}/.+\.rb$} )
  end

  watch( %r{^bin/\w+$} )
  watch(/\b[A-Z][a-z]file$/)
  watch('.rubocop.yml')     { everything }
  watch('rubocop-todo.yml') { everything }
end
