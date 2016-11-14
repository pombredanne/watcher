require 'bundler'
Bundler.require

def follow_feed(url, platform)
  memcached_options = {
    server: (ENV["MEMCACHIER_SERVERS"] || "localhost:11211").split(","),
    username: ENV["MEMCACHIER_USERNAME"],
    password: ENV["MEMCACHIER_PASSWORD"],
    failover: true,
    socket_timeout: 1.5,
    socket_failure_delay: 0.2
  }
  client = Feedtosis::Client.new(url, backend: Moneta.new(:MemcachedDalli, memcached_options))
  while(true) do
    new_entries = client.fetch.new_entries
    if new_entries
      new_entries.each do |entry|
        name = entry.title.split(' ').first
        puts "#{platform}/#{name}"
        Sidekiq::Client.push('queue' => 'default', 'class' => 'RepositoryDownloadWorker', 'args' => [platform, name])
      end
    end
    sleep 30
  end
end

threads = []

feeds = [
  ['http://registry.npmjs.org/-/rss?descending=true&limit=50', 'npm'],
  ['http://packagist.org/feeds/releases.rss', 'composer'],
  ['http://packagist.org/feeds/packages.rss', 'composer'],
  ['http://hackage.haskell.org/packages/recent.rss', 'hackage'],
  ['http://lib.haxe.org/rss/', 'haxelib'],
  ['http://pypi.python.org/pypi?%3Aaction=rss', 'pypi'],
  ['http://pypi.python.org/pypi?%3Aaction=packages_rss', 'pypi']
]
feeds.each do |feed|
  threads << Thread.new do
    follow_feed(feed[0], feed[1])
  end
end

threads.each { |thr| thr.join }
