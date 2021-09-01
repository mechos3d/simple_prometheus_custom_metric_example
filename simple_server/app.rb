# myapp.rb
require 'sinatra'
require 'prometheus/client'
require 'prometheus/middleware/exporter'

class Application < Sinatra::Base
  use Rack::Deflater
  # use Prometheus::Middleware::Collector
  use Prometheus::Middleware::Exporter

  # returns a default registry
  prometheus = Prometheus::Client.registry
  # create a new counter metric
  foo_custom_counter = Prometheus::Client::Counter.new(:foo_custom_counter, docstring: 'A simple custom counter example')
  # register the metric
  prometheus.register(foo_custom_counter)

  puts 'Done initializing'

  get '/foo' do
    # start using the counter
    foo_custom_counter.increment
    'foo1'
  end
end
