import os
import urllib.parse

diagrams = [
    "02-bu-aligned-org-structure",
    "03-naming-convention",
    "04-hardened-alertmanager-flow",
    "05-adoption-strategy"
]

drawio_template = """<mxfile host="app.diagrams.net" agent="Antigravity" version="22.0.0">
  <diagram name="Page-1" id="{name}">
    <mxGraphModel dx="1422" dy="800" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1200" pageHeight="1200" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="svg-image" value="" style="shape=image;verticalLabelPosition=bottom;labelBackgroundColor=#ffffff;verticalAlign=top;aspect=fixed;imageAspect=0;image=data:image/svg+xml,{svg_data}" vertex="1" parent="1">
          <mxGeometry x="0" y="0" width="{width}" height="{height}" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>"""

for name in diagrams:
    svg_file = f"{name}.svg"
    drawio_file = f"{name}.drawio"
    
    if not os.path.exists(svg_file):
        continue
        
    with open(svg_file, "r") as f:
        svg_content = f.read()
        
    # Extract width and height from SVG tag if possible, default to 800x600
    width = "800"
    height = "600"
    if 'width="' in svg_content:
        width = svg_content.split('width="')[1].split('"')[0]
    if 'height="' in svg_content:
        height = svg_content.split('height="')[1].split('"')[0]
        
    svg_encoded = urllib.parse.quote(svg_content)
    drawio_content = drawio_template.format(name=name, svg_data=svg_encoded, width=width, height=height)
    
    with open(drawio_file, "w") as f:
        f.write(drawio_content)
    
    print(f"Updated {drawio_file}")
