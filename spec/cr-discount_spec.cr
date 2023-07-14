require "./spec_helper"

describe "Discount" do
  # TODO: Write tests

  it "works" do
    markdown = "This *is* **markdown**"
    doc = LibDiscount.mkd_string(markdown.to_unsafe, markdown.bytesize, LibDiscount::FLAGS)
    LibDiscount.mkd_compile(doc, LibDiscount::FLAGS)
    _html = Pointer(Pointer(LibC::Char)).malloc 1
    size = LibDiscount.mkd_document(doc, _html)
    slice = Slice.new(_html.value, size)
    html = String.new(slice)
    LibDiscount.mkd_cleanup(doc)
    html.should eq "<p>This <em>is</em> <strong>markdown</strong></p>"
  end

  it "works with nicer API" do
    Discount.compile("This *is* **markdown**").should eq "<p>This <em>is</em> <strong>markdown</strong></p>"
  end
end
