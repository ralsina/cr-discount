# cr-discount

A crystal wrapper for [Discount](http://www.pell.portland.or.us/~orc/Code/discount/),
a Markdown implementation

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     cr-discount:
       github: ralsina/cr-discount
   ```

2. Run `shards install`

## Usage

```crystal
require "cr-discount"
```

You can use Discount to compile markdown to HTML like this:

```crystal
      markdown = "This *is* **markdown**"
      html = Discount.compile(markdown)
```

This is the whole API:

```crystal
  # Compile `text` from Markdown to HTML
  def self.compile(
    text : String,
    with_toc : Bool = false,
    flags = LibDiscount::MKD_FENCEDCODE | LibDiscount::MKD_TOC
  )
```

* `with_toc` adds a simple table of contents at the beginning of
  the returned HTML
* `flags` can be any combination of the flags in
  [the discount docs](http://www.pell.portland.or.us/~orc/Code/discount/)

## Development

I am not planning on developing this much further since it already does what I want :-)

## Contributing

1. Fork it (<https://github.com/ralsina/cr-discount/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Roberto Alsina](https://github.com/ralsina) - creator and maintainer
