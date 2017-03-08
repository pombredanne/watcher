# [Watcher](https://libraries.io/github/librariesio/watcher)

Ruby app for enqueuing sidekiq jobs for [Libraries.io](https://libraries.io) from package manager rss feeds.

## Development

Source hosted at [GitHub](http://github.com/librariesio/watcher).
Report issues/feature requests on [GitHub Issues](http://github.com/librariesio/watcher/issues). Follow us on Twitter [@librariesio](https://twitter.com/librariesio). We also hangout on [Gitter](https://gitter.im/librariesio/support).

### Getting Started

New to Ruby? No worries! You can follow these instructions to install a local server, or you can use the included Vagrant setup.

#### Installing a Local Server

First things first, you'll need to install Ruby 2.3.3. I recommend using the excellent [rbenv](https://github.com/sstephenson/rbenv),
and [ruby-build](https://github.com/sstephenson/ruby-build)

```bash
rbenv install 2.3.3
rbenv global 2.3.3
```

### Running the watcher

Start the watcher with the following command:

    bundle exec ruby watcher.rb

### Note on Patches/Pull Requests

 * Fork the project.
 * Make your feature addition or bug fix.
 * Add tests for it. This is important so I don't break it in a
   future version unintentionally.
 * Add documentation if necessary.
 * Commit, do not change procfile, version, or history.
 * Send a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2017 Andrew Nesbitt. See [LICENSE](https://github.com/librariesio/watcher/blob/master/LICENSE) for details.
