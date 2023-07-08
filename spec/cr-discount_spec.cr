require "./spec_helper"

describe "Discount" do
  # TODO: Write tests

  it "works" do
      markdown = "This *is* **markdown**"
      doc = Discount.mkd_string(markdown.to_unsafe, markdown.bytesize, Discount::FLAGS)
      Discount.mkd_compile(doc, Discount::FLAGS)
      _html = Pointer(Pointer(LibC::Char)).malloc 1
      size = Discount.mkd_document(doc, _html)
      slice = Slice.new(_html.value, size)
      html = String.new(slice)
      Discount.mkd_cleanup(doc)
      html.should eq "<p>This <em>is</em> <strong>markdown</strong></p>"
  end
end
