# qk/quik - ruby quick starter template script wizard .:. the missing code generator

* home  :: [github.com/rubylibs/quik](https://github.com/rubylibs/quik)
* bugs  :: [github.com/rubylibs/quik/issues](https://github.com/rubylibs/quik/issues)
* gem   :: [rubygems.org/gems/quik](https://rubygems.org/gems/quik)
* rdoc  :: [rubydoc.info/gems/quik](http://rubydoc.info/gems/quik)


## Usage

The quick gem includes a command line tool that lets you
run quick starter template scripts. Try:

```
$ quik --help      # or
$ qk -h
```

Resulting in:

```
NAME
    qk/quik - ruby quick starter template script wizard .:. the missing code generator

SYNOPSIS
    quik [global options] command [command options] [arguments...]

VERSION
    0.1.0

GLOBAL OPTIONS
    --help            - Show this message
    --test, --dry_run - (Debug) Dry run; run script in simulation for testing
    --verbose         - (Debug) Show debug messages
    --version         - Display the program version

COMMANDS
    new, n - Run ruby quick starter script

    help   - Shows a list of commands or help for one command
    test   - (Debug) Test command suite
```


### Commands

[New Wizard](#new-wizard-command---new-n)

#### New Wizard Command - `new`, `n`

To run a quick starter template wizard script
to download and install (unzip/unpack) a template archive and configure
the code ready-to-use. Try:


```
$ quik new gem    # or
$ quik n gem      # or
$ qk n gem
```

This will download the `gem.rb` wizard script
from the [Rubyref Scripts](https://github.com/rubyref/scripts) repo
and run through all steps e.g.:

```
Welcome, to the gem quick starter script.

Q: What's your gem's name? [hola]:   hello
Q: What's your gem's module? [Hola]: Hello

Thanks! Ready-to-go. Stand back.

  Downloading Rubyref Gem Starter Template...
  Setting up Rubyref Starter Template...
  ...
Done.
```

That's it. Now the gem starter code is ready in the `hello`
folder.


**More Quick Starter Wizard Scripts**

For more ruby quick starter scripts, see the [Rubyref Scripts](https://github.com/rubyref/scripts) library.

For static site (e.g. jekyll) quick starter scripts, see the  [Mr. Hyde's Scripts](https://github.com/mrhydescripts/scripts) library.



## Install

Just install the gem:

    $ gem install quik


## License

The `quik` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.

## Questions? Comments?

Send them along to the ruby-talk mailing list.
Thanks!
