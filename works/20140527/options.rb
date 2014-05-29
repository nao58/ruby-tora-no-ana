# encoding: utf-8


default_options = {
  'domain' => 'www.netprice.co.jp',
  'path' => '/',
  'expires' => 3600*24*7
}

item_options = {
  'path' => '/hagi',
  'expires' => 3600
}

options = default_options.dup
#options = default_options
options.merge! item_options unless item_options.nil?

p default_options.merge(options)
p default_options.merge(default_options)
