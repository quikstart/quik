require 'hoe'
require './lib/quik/version.rb'

Hoe.spec 'quik' do

  self.version = Quik::VERSION

  self.summary = 'quik'
  self.description = summary

  self.urls    = ['https://github.com/rubylibs/quik']

  self.author  = 'Gerald Bauer'
  self.email   = 'ruby-talk@ruby-lang.org'

  # switch extension to .markdown for gihub formatting
  self.readme_file  = 'README.md'
  self.history_file = 'HISTORY.md'

  self.extra_deps = [
    ['logutils'],
    ['fetcher'],
    ['rubyzip'],
  ]

  self.licenses = ['Public Domain']

  self.spec_extras = {
   required_ruby_version: '>= 1.9.2'
  }

end
