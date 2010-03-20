module Jekyll

  class SvgTag < Liquid::Tag
    def initialize( tag_name, svg, tokens )
      super
      @svg = svg.strip
    end

    def render(context)
      png = @svg.sub( /(\.svg)$/, '.png' )
      ident = `identify #{png}`
      w,h = [ $1, $2 ] if ident =~ /PNG (\d+)x(\d+)/
      <<END
<div style="text-align: center;">
  <object data="#{@svg}" type="image/svg+xml" width="#{w}" height="#{h}">
    <img src="#{png}" width="#{w}" height="#{h}">
  </object>
</div>
END
    end
  end
end

Liquid::Template.register_tag('svg', Jekyll::SvgTag)
