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
      doc = Discount.mkd_string(markdown.to_unsafe, markdown.bytesize, Discount::FLAGS)
      Discount.mkd_compile(doc, Discount::FLAGS)
      _html = Pointer(Pointer(LibC::Char)).malloc 1
      size = Discount.mkd_document(doc, _html)
      slice = Slice.new(_html.value, size)
      html = String.new(slice)
      Discount.mkd_cleanup(doc)
```

Don't be scared by all the weird stuff, the only interesting bits are:

* `markdown` is a String
* `html` is a String
* Only call `mdk_cleanup` **after** you create html

`Discount::FLAGS` is set to `Discount::MKD_TOK` but you can use any combination of
the flags in [the discount docs](http://www.pell.portland.or.us/~orc/Code/discount/) 

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
