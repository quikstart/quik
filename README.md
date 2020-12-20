# qk/quik - ruby quick starter template script wizard .:. the missing code generator

* home  :: [github.com/quikstart/quik](https://github.com/quikstart/quik)
* bugs  :: [github.com/quikstart/quik/issues](https://github.com/quikstart/quik/issues)
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
    1.0.0

GLOBAL OPTIONS
    --help            - Show this message
    --test, --dry_run - (Debug) Dry run; run script in simulation for testing
    --verbose         - (Debug) Show debug messages
    --version         - Display the program version

COMMANDS
    list, ls, l - List ruby quick starter scripts
    new, n      - Run ruby quick starter script

    help        - Shows a list of commands or help for one command
    test        - (Debug) Test command suite
```


### Commands

[List Wizards](#list-wizard-command---list-ls-l) •
[New Wizard](#new-wizard-command---new-n)


#### List Wizards Command - `list`, `ls`, `l`

Use:

```
$ quik list    # or
$ quik ls      # or
$ quik l       # or
$ qk l
```

Resulting in:

```
  1..gem        .:.  Gem Quick Starter Template
  2..gem-hoe    .:.  Gem Quick Starter Template (Hoe Classic Edition)
  3..sinatra    .:.  Sinatra Quick Starter Template
...
```


#### New Wizard Command - `new`, `n`

To run a quick starter template wizard script
to download and install (unzip/unpack) a template archive and configure
the code ready-to-use. Try:


```
$ quik new gem    # or
$ quik n gem      # or
$ qk n gem
```

This will download the [`quik.rb`](https://github.com/quikstart/gem-starter-template/blob/master/quik.rb) wizard script from the
gem starter template repo
and run through all steps e.g.:

```
Welcome, to the gem quick starter script.

Q: What's your gem's name? [hola]:   hello
Q: What's your gem's module? [Hola]: Hello

Thanks! Ready-to-go. Stand back.

  Downloading Gem Starter Template...
  Setting up Gem Starter Template...
  ...
Done.
```

That's it. Now the gem starter code is ready in the `hello`
folder.


**More Quick Starter Wizard Scripts**

For more ruby quick starter scripts, see the [Quik Scripts](https://github.com/quikstart/scripts)
catalog / directory.


## Install

Just install the gem:

    $ gem install quik


## License

The `quik` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.

## Questions? Comments?

Send them along to the ruby-talk mailing list.
Thanks!
