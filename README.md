# Ropes

This is a simple gem you can use either programmatically or via a simple utility to build
apt and yum repositories from either a directory of package files, or from information
you supply.

It will generate the following files:
* `Releases`
* `Releases.gpg` (if you specify a GPG key to use)
* `Contents-{arch}.gz`
* Packages.gz
* Packages.bz2

## Installation

Add this line to your application's Gemfile:

    gem 'ropes'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ropes

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
