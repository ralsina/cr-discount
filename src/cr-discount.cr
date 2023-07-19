@[Link("markdown")]
lib LibDiscount
  fun mkd_string(buffer : Pointer(LibC::Char), size : Int32, flags : Int32) : Void*
  fun mkd_compile(doc : Void*, flags : Int32) : Int32
  fun mkd_document(doc : Void*, html : Pointer(Pointer(LibC::Char))) : Int32
  fun mkd_toc(doc : Void*, toc : Pointer(Pointer(LibC::Char))) : Int32
  fun mkd_cleanup(doc : Void*)
  MKD_NOLINKS          = 0x00000001 # don't do link processing, block <a> tags
  MKD_NOIMAGE          = 0x00000002 # don't do image processing, block <img>
  MKD_NOPANTS          = 0x00000004 # don't run smartypants()
  MKD_NOHTML           = 0x00000008 # don't allow raw html through AT ALL
  MKD_STRICT           = 0x00000010 # disable SUPERSCRIPT, RELAXED_EMPHASIS
  MKD_TAGTEXT          = 0x00000020 # process text inside an html tag; no <em>, no <bold>, no html or [] expansion
  MKD_NO_EXT           = 0x00000040 # don't allow pseudo-protocols
  MKD_CDATA            = 0x00000080 # generate code for xml ![CDATA[...]]
  MKD_NOSUPERSCRIPT    = 0x00000100 # no A^B
  MKD_NORELAXED        = 0x00000200 # emphasis happens /everywhere/
  MKD_NOTABLES         = 0x00000400 # disallow tables
  MKD_NOSTRIKETHROUGH  = 0x00000800 # forbid ~~strikethrough~~
  MKD_TOC              = 0x00001000 # do table-of-contents processing
  MKD_1_COMPAT         = 0x00002000 # compatibility with MarkdownTest_1.0
  MKD_AUTOLINK         = 0x00004000 # make http://foo.com link even without <>s
  MKD_SAFELINK         = 0x00008000 # paranoid check for link protocol
  MKD_NOHEADER         = 0x00010000 # don't process header blocks
  MKD_TABSTOP          = 0x00020000 # expand tabs to 4 spaces
  MKD_NODIVQUOTE       = 0x00040000 # forbid >%class% blocks
  MKD_NOALPHALIST      = 0x00080000 # forbid alphabetic lists
  MKD_NODLIST          = 0x00100000 # forbid definition lists
  MKD_EXTRA_FOOTNOTE   = 0x00200000 # enable markdown extra-style footnotes
  MKD_NOSTYLE          = 0x00400000 # don't extract <style> blocks
  MKD_NODLDISCOUNT     = 0x00800000 # disable discount-style definition lists
  MKD_DLEXTRA          = 0x01000000 # enable extra-style definition lists
  MKD_FENCEDCODE       = 0x02000000 # enabled fenced code blocks
  MKD_IDANCHOR         = 0x04000000 # use id= anchors for TOC links
  MKD_GITHUBTAGS       = 0x08000000 # allow dash and underscore in element names
  MKD_URLENCODEDANCHOR = 0x10000000 # urlencode non-identifier chars instead of replacing with dots
  MKD_LATEX            = 0x40000000 # handle embedded LaTeX escapes
  MKD_EXPLICITLIST     = 0x80000000 # don't combine numbered/bulletted lists

  FLAGS = MKD_FENCEDCODE | MKD_TOC
end

module Discount
  # Compile `text` from Markdown to HTML
  def self.compile(
    text : String,
    with_toc : Bool = false,
    flags = LibDiscount::MKD_FENCEDCODE | LibDiscount::MKD_TOC
  ) : Array(String)
    doc = LibDiscount.mkd_string(text.to_unsafe, text.bytesize, flags)
    LibDiscount.mkd_compile(doc, flags)
    _html = Pointer(Pointer(LibC::Char)).malloc 1
    size = LibDiscount.mkd_document(doc, _html)
    slice = Slice.new(_html.value, size)
    html = String.new(slice)
    if with_toc
      toc = Pointer(Pointer(LibC::Char)).malloc 1
      toc_size = LibDiscount.mkd_toc(doc, toc)
      toc_s = String.new(Slice.new(toc.value, toc_size))
      LibDiscount.mkd_cleanup(doc)
      return [html, toc_s]
    end
    LibDiscount.mkd_cleanup(doc)
    [html, ""]
  end
end
