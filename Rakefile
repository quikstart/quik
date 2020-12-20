require 'hoe'
require './lib/quik/version.rb'

Hoe.spec 'quik' do

  self.version = Quik::VERSION

  self.summary = 'qk/quik - ruby quick starter template script wizard .:. the missing code generator'
  self.description = summary

  self.urls    = { home: 'https://github.com/quikstart/quik' }

  self.author  = 'Gerald Bauer'
  self.email   = 'ruby-talk@ruby-lang.org'

  # switch extension to .markdown for gihub formatting
  self.readme_file  = 'README.md'
  self.history_file = 'CHANGELOG.md'

  self.extra_deps = [
    ['logutils'],
    ['fetcher'],
    ['rubyzip'],
    ['gli'],
  ]

  self.licenses = ['Public Domain']

  self.spec_extras = {
   required_ruby_version: '>= 2.2.2'
  }

end
