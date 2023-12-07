#let COLORS = (
  primary:   rgb("#00A6D6"),
  secondary: rgb("#99D28C"),
)
#let BULLETS_FN = (level) => {
  set text(fill: COLORS.primary)
  ([•], [‣]).at(level)
}

#let SLIDE_INSET = 2cm
#let SPACING = 1cm
#let PROGRESS_BAR_HEIGHT = 0.5cm

#let CONTENT_SLIDE = (
  title_font_size: 32pt,
  text_font_size: 24pt,
  numbering_font_size: 20pt,
)
#let TOPIC_SLIDE = (
  title_font_size: 32pt,
  subtitle_font_size: 24pt,
)

#let slide_counter = counter("slide-counter")

#let conf(doc) = {
  set page(
    paper: "presentation-16-9",
    margin: (x: 0cm, y: 0cm),
  )
  show list: p => [
    #set list(marker: BULLETS_FN)
    #p
  ]
  doc
}

#let show_heading(
  body,
  fill: COLORS.primary,
  font: "Roboto Slab",
  weight: "medium",
) = [
  #show heading: it => [
    #set text(
      fill: fill,
      font: font,
      weight: weight,
    )
    #it
  ]
  #body
]

#let bare-slide(body) = [
  #body
  #pagebreak(weak: true)
]

#let numbered-slide(body) = bare-slide({
  slide_counter.step()
  locate(loc => grid(
      rows: (PROGRESS_BAR_HEIGHT, 1fr),
      rect(
        stroke: none,
        fill: COLORS.primary,
        width: 100% * (slide_counter.at(loc).at(0) / slide_counter.final(loc).at(0)),
      ),
      box(
        inset: (
          top: SLIDE_INSET - PROGRESS_BAR_HEIGHT,
          left: SLIDE_INSET,
          right: SLIDE_INSET,
          bottom: 0cm
        ),
        grid(
          rows: (1fr, 3cm),
          row-gutter: SPACING,
          body,
          grid(
            columns: (1fr, 1fr),
            image("assets/logo/TUDelft_logo_rgb.svg", height: 100%),
            align(right + horizon, {
              set text(size: CONTENT_SLIDE.numbering_font_size)
              slide_counter.display()
            }),
          )
        )
      )
    )
  )
})

#let title-slide(title, author: none) = {
    bare-slide(
      align(center + horizon, show_heading[
          #heading(level: 1, outlined: false, title)
  
          #if author != none [
              #heading(level: 2, outlined: false, author)
          ]
      ])
    )
}
#let topic-slide(title, subtitle: none) = {
  bare-slide(
    rect(width: 100%, inset: (x: SLIDE_INSET, y: 0cm), fill: COLORS.primary, stroke: none, 
        grid(
          rows: (20%, 60%, 20%),
          [],
          align(left + horizon, show_heading(fill: white)[
              #show heading: it => {
                set text(size: if it.level == 1 {
                  TOPIC_SLIDE.title_font_size
                } else {
                  TOPIC_SLIDE.subtitle_font_size
                })
                
                it
              }
              
              = #title

              #if subtitle != none [
                  #heading(level: 2, outlined: false, subtitle)
              ]
          ]),
          align(left + horizon, [
              #image("./assets/logo/TUDelft_logo_white.svg", height: 100%)
          ]), [], 
      )
    )
  )
}

#let slide(body, rhs_figure: none, title: "Placeholder Title") = {
  numbered-slide(
    grid(
      rows: (32pt, 1fr),
      row-gutter: SPACING,
      show_heading[
        #set text(size: CONTENT_SLIDE.title_font_size)
        #heading(level: 6, title)
      ],
      [
        #set text(
          font: "Noto Serif Display",
          size: CONTENT_SLIDE.text_font_size,
        )

        #if rhs_figure == none [
          #body
        ] else [
          #grid(
            columns: (1fr, 1fr),
            gutter: 1cm,
            [ #body ],
            align(center + horizon, rhs_figure)
          )
        ]
      ],
    )
  )
}

#let outline-slide(title: "Table of Contents") = slide(
  title: title,
  locate(loc => {
    let headers = query(heading, loc).filter(it => it.outlined)

    list(..headers.map(h => list.item(h.body)))
  }),
)


#let bare-bg-slide(body) = bare-slide[
  #set page(background: rect(fill: COLORS.primary, width: 100%, height: 100%))
  #image("./assets/background.svg", width: 100%)
  #place(dy: -100% - 1em)[
    #body
  ]
]