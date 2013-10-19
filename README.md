# Ropes

This is a simple gem you can use either programmatically or via a simple utility to build
apt and yum repositories from either a directory of package files, or from information
you supply.

It will generate the following files:
* `Releases`
* `Releases.gpg` (if you specify a GPG key to use)
* `Contents-{arch}.gz`
* `Packages`
* `Packages.gz`
* `Packages.bz2`

## Current status

As of 0.0.1, it generates only `Releases`, `Releases.gpg`, `Packages` and `Packages.gz`.
This is enough to get a basic Ubuntu repository working. There is no yum support.

## Installation

Add this line to your application's Gemfile:

    gem 'ropes'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ropes

## Usage

Here's an example of creating a repository object, adding a few packages to it,
then retrieving the various repository files. It's your reponsibility at the moment
to put files in the correct places - once there's a command line tool, it'll do this
for you.

    repo = Ropes::Repository.new({
      :origin => "andytinycat",
      :type => :apt,
      :distribution => "precise",
      :version => "12.04",
      :architecture => "amd64",
      :components => "main",
      :description => "testing",
      :package_base => "packages"
    })

    repo.add_file_by_path("some_custom_package.deb")

    File.open("Packages", "w") do |file|
      file.write repo.packages_file
    end

    File.open("Release", "w") do |file|
      file.write repo.release_file
    end

    File.open("Release.gpg", "w") do |file|
      file.write repo.release_file_gpg("/path/to/your/gpg.key")
    end

    File.open("Packages.gz", "w") do |file|
      file.write repo.packages_file_gz
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
