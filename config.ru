require 'rubygems'
require 'sinatra'
require 'pry-debugger'
require 'haml'

require 'instagram'

require './app'

require 'faye'

use Faye::RackAdapter,
    :mount      => '/faye',
    :timeout    => 25,
    :extensions => []

run InstaMasher
