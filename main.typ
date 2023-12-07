#import "tudelft-template.typ": conf, COLORS, bare-slide, title-slide, outline-slide, topic-slide, slide, bare-bg-slide, show_heading
#show: doc => conf(doc)

#bare-slide[
  #align(center + horizon, [
    #heading(level: 1, outlined: false, [ WP3 Kick-off Meeting ])

    #box(inset: (x: 5cm),
      grid(
        columns: (1fr, 1fr, 1fr),
        column-gutter: 1cm,
        image("./assets/logo/TUDelft_logo_rgb.svg"),
        image("./assets/logo/TUDelft_logo_rgb.svg"),
        image("./assets/logo/TUDelft_logo_rgb.svg"),
      )
    )
  ])
]
#title-slide(author: "Gijs Burghoorn")[Hello!]
#outline-slide()
#topic-slide(subtitle: "Resilient Trust")[WP3 Kick Off]
#slide(title: "Title Placeholder")[
- Point 1
  + dsajlsdjaflj
  - dsafjlka
- Point 2
]

#slide(title: "Hello!", rhs_figure: [
  #figure(caption: "Caption")[
    #image("./assets/logo/TUDelft_logo_rgb.svg")
  ]
])[
- Point 1
  - dsajlsdjaflj
]

#bare-bg-slide[
  #box(inset: 2cm, width: 100%, height: 100%, show_heading(fill: white, align(right + bottom, stack(dir: ttb, spacing: 1cm,
    [ = Title Placeholder ],
    [ == Subtitle Placeholder ]
  ))))
]
