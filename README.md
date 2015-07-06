# ForwardingDsl

[![Gem Version](https://badge.fury.io/rb/forwarding_dsl.svg)](http://badge.fury.io/rb/forwarding_dsl)
[![Code Climate](https://codeclimate.com/github/manuelmorales/forwarding-dsl/badges/gpa.svg)](https://codeclimate.com/github/manuelmorales/forwarding-dsl)
[![Test Coverage](https://codeclimate.com/github/manuelmorales/forwarding-dsl/badges/coverage.svg)](https://codeclimate.com/github/manuelmorales/forwarding-dsl/coverage)
[![Build Status](https://travis-ci.org/manuelmorales/forwarding-dsl.svg)](https://travis-ci.org/manuelmorales/forwarding-dsl)

ForwardingDsl makes it easy to build user friendly DSLs.
While `ForwardingDsl.run` will allow you to create a DSL from a regular object,
`ForwardingDsl::Getsetter` will make easy to declare attributes for it.
It is inspired by the blog post [instance_eval with access to outside scope](http://djellemah.com/blog/2013/10/09/instance-eval-with-access-to-outside-scope/).

Benefits:

* Makes it trivial to provide a DSL. Wrap anything with `ForwardingDsl.run()` and you are done.
* Unlike `instance_eval`, only the public API of your object is reachable from the DSL.
* Unlike `instance_eval`, methods available outside of the DSL are still available inside.
* Compatible with the explicit `yield(self)`, no DSL, style.


## Usage

Wrap any object to make a DSL out of it:

```ruby
require 'forwarding_dsl'

App = Struct.new(:host, :port)
app = App.new("localhost", 80)

ForwardingDsl.run app do
  host
end
# => "localhost"
```

Use `ForwardingDsl::Getsetter` to declare attributes that receive values
on a declarative way:

```ruby
class MyApp
  include ForwardingDsl::Getsetter

  getsetter :host, :port

  def initialize &block
    ForwardingDsl.run(my_object, &block)
  end
end

app = MyApp.new do
  host 'localhost'
  port 80
end

app.host # => 'localhost'
app.port # => 80
```

`ForwardingDsl` is also compatible with the classic `yield(self)`.
The context of the block will remain untouched in that case:

```ruby
app = MyApp.new do |a|
  a.host 'localhost'
  a.port = 80
end
```

Methods available outside of the DSL block are also available inside:

```ruby
def port_configuration
  configuration[:port]
end

app = MyApp.new do
  port port_configuration
end
```

If needed, the yielded object is available explicitly through `this`
and the outer context through `that`:

```ruby
def port_configuration
  configuration[:port]
end

app = MyApp.new do
  this.port = that.port_configuration
end
```


## Contributing

Do not forget to run the tests with:

```bash
rake
```

And bump the version with any of:

```bash
$ gem bump --version 1.1.1       # Bump the gem version to the given version number
$ gem bump --version major       # Bump the gem version to the next major level (e.g. 0.0.1 to 1.0.0)
$ gem bump --version minor       # Bump the gem version to the next minor level (e.g. 0.0.1 to 0.1.0)
$ gem bump --version patch       # Bump the gem version to the next patch level (e.g. 0.0.1 to 0.0.2)
```


## License

Released under the MIT License.
See the [LICENSE](LICENSE.txt) file for further details.

