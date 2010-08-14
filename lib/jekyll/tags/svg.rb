module Jekyll

  class SvgTag < Liquid::Tag
    def initialize( tag_name, svg, tokens )
      super
      @svg = svg.strip
    end

    def render(context)
      png = @svg.sub( /(\.svg)$/, '.png' )
      w,h = open( png, 'rb' ) do |fpng|
        ImageSize.new( fpng.read ).get_size
      end
      <<END
<div class="svg-object">
  <object data="#{@svg}" type="image/svg+xml" width="#{w}" height="#{h}">
    <img src="#{png}" width="#{w}" height="#{h}">
  </object>
</div>
END
    end
  end
end

Liquid::Template.register_tag('svg', Jekyll::SvgTag)
