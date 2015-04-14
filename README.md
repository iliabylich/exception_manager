# ExceptionManager

Gem for better exception recording.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'exception_manager'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install exception_manager

## Usage

First of all, make sure that ExceptionManager is enabled in your application.

```ruby
# config/initializers/exception_manager.rb
ExceptionManager.enable!
```

That's it! Now you can use it.

```ruby
class TestClassThatRaisesException
  @@class_variable = :class_value

  def test_error(*args)
    @instance_variable = :instance_value

    raise 'Test error'
  end
end

begin
  TestClassThatRaisesException.new.test_error(1, 2, 3)
rescue => e
  puts "Subject: #{e.subject}"
  puts "Locals: #{e.locals}"
  puts "Instance variables: #{e.subject_instance_variables}"
  puts "Class variables: #{e.subject_class_variables}"
  puts "Summary: #{e.summary.inspect}"
end
```

And if you have `pry`, you can combine it:
```ruby
e._binding.pry
```

## Integration with monitoring systems like NewRelic

NewRelic uses `to_s` method for fetching message from exception
(https://github.com/newrelic/rpm/blob/master/lib/new_relic/noticed_error.rb#L33).
Unfortunately you cannot override `to_s` method like this:

```ruby
# DO NOT ADD THIS CODE TO YOUR PROJECT
# IF YOU DON'T WANT TO GET SEGFAULT
class YourApiBaseException < StandardError
  def to_s
    [super, summary.inspect].join(' ')
  end
end
```

The solution is in this line: https://github.com/newrelic/rpm/blob/master/lib/new_relic/noticed_error.rb#L31
Instead of overriding `to_s` method we can override `original_exception` method:

```ruby
# This code is safe
class YourApiBaseException < StandardError
  def original_exception
    message_for_new_relic = [message, summary.inspect].join(' ')
    self.exception(message_for_new_relic)
  end
end
```

From this moment all exceptions inherited from `YourApiBaseException` will have message
with exception summary:
```ruby
begin
  raise YourApiBaseException, 'my custom message'
rescue YourApiBaseException => e
  puts e.original_exception.to_s # this is exactly what NewRelic gem calls
end
# => 'my custom message {:locals=>..., :subject=>..., }'
```


Other systems may use `message` method, so the code will look like:
```ruby
class YourApiBaseException < StandardError
  def message
    [super, summary.inspect].join(' ')
  end
end
```

If you don't know exactly which method is used in your monitoring system,
you can simply override both :smile:

## Contributing

1. Fork it ( https://github.com/[my-github-username]/exception_manager/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
