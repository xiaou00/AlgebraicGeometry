// ─────────────────────────────────────────────
//  Math Notes Template
// ─────────────────────────────────────────────

#let ink    = rgb("#111827")        // near-black for headings & title
#let muted  = rgb("#64748b")       // secondary text
#let rule-c = rgb("#d1d5db")       // light gray for decorative lines

// environment colors
#let c-thm  = rgb(30,  150, 220)   // theorem  — sky blue (softened)
#let c-def  = rgb(215,  45,  45)   // definition — red (less harsh)
#let c-prop = rgb(20,  130, 190)   // proposition / lemma / corollary
#let c-con  = rgb(16,  170, 120)   // example — teal (darkened)
#let c-rem  = rgb(148, 163, 184)   // remark

#let songti-fonts = (
  "SimSun",
  "Songti SC",
  "Noto Serif CJK SC",
  "Source Han Serif SC",
  "LXGW WenKai GB Screen",
  "LXGW WenKai Screen",
  "FreeSerif",
)

#let _env-counter(tag) = counter("env-" + tag)

#let _reset-env-counters() = {
  for tag in ("theorem", "lemma", "corollary", "proposition", "definition", "axiom") {
    _env-counter(tag).update(0)
    counter(figure.where(kind: tag)).update(0)
  }
}

// ── Page setup ───────────────────────────────
#let conf(
  title:    "",
  subtitle: "",
  author:   "",
  date:     "",
  doc,
) = {
  set page(
    paper:        "a4",
    margin:       (x: 3cm, top: 2.8cm, bottom: 2.5cm),
    header: context {
      if counter(page).get().first() > 2 {
        grid(
          columns: (1fr, 1fr),
          align(left,  text(size: 8pt, fill: muted, title)),
          align(right, text(size: 8pt, fill: muted,
            counter(page).display("1 / 1", both: true))),
        )
        v(-6pt)
        line(length: 100%, stroke: 0.4pt + muted)
      }
    },
    footer: none,
  )

  set text(
    font:   ("Libertinus Serif", "LXGW WenKai GB Screen", "LXGW WenKai Screen", "FreeSerif"),
    size:   11pt,
    lang:   "zh",
  )

  show math.equation: set text(font: ("Libertinus Math",) + songti-fonts)

  set par(justify: true, leading: 0.75em, spacing: 1.1em)

  // fake bold for CJK fonts that lack a bold variant
  show strong: it => text(stroke: 0.35pt + black, weight: "bold", it)

  set math.equation(numbering: none)

  set heading(numbering: "1.1")

  // headings
  show heading.where(level: 1): it => {
    _reset-env-counters()
    pagebreak(weak: true)
    v(1.4em)
    block({
      text(size: 20pt, weight: "bold", fill: ink,
        context counter(heading).display("1.") + " " + it.body
      )
      v(4pt)
      line(length: 100%, stroke: 0.8pt + rule-c)
    })
    v(0.8em)
  }
  show heading.where(level: 2): it => {
    v(1.4em)
    context text(size: 13pt, weight: "bold", fill: ink,
      text(fill: c-def, "§ ")
      + counter(heading).display("1.1") + "  "
      + it.body
    )
    v(0.5em)
  }
  show heading.where(level: 3): it => {
    v(0.8em)
    context text(size: 11pt, weight: "semibold", fill: ink,
      counter(heading).display("1.1.1") + "  " + it.body
    )
    v(0.25em)
  }

  // ── title block ──────────────────────────────
  align(center, {
    v(1fr)
    text(size: 32pt, weight: "bold", fill: ink, title)
    if subtitle != "" {
      linebreak()
      v(6pt)
      text(size: 14pt, fill: muted, subtitle)
    }
    v(14pt)
    line(length: 55%, stroke: 0.8pt + rule-c)
    v(10pt)
    if author != "" or date != "" {
      text(size: 10pt, fill: muted,
        if author != "" and date != "" { author + "  ·  " + date }
        else if author != ""           { author }
        else                           { date }
      )
    }
    v(1fr)
  })

  pagebreak()

  // ── table of contents ────────────────────────
  {
    show outline.entry.where(level: 1): it => {
      v(20pt, weak: true)
      strong(it)
    }
    // 手动渲染标题, 避免被 heading 规则编号
    block({
      text(size: 20pt, weight: "bold", fill: ink, "目录")
      v(4pt)
      line(length: 100%, stroke: 0.8pt + rule-c)
    })
    v(0.8em)
    outline(
      title: none,
      indent: 1.5em,
      depth: 2,
    )
  }

  pagebreak()

  doc
}

// ── Theorem environments ──────────────────────

#let _env(tag, label, color, title, body, numbering: true) = {
  let cnt = _env-counter(tag)
  let env-body = {
    if numbering { cnt.step() }
    block(
      width:   100%,
      inset:   (left: 12pt, right: 12pt, top: 9pt, bottom: 9pt),
      radius:  3pt,
      fill:    color.lighten(90%),
      stroke:  (left: 3pt + color),
      align(left, {
        context {
          let hs = counter(heading).get()
          let chapter = hs.at(0, default: 0)
          let section = hs.at(1, default: 0)
          let n = cnt.get().first()
          let number = str(chapter) + "." + str(section) + "." + str(n)

          text(weight: "semibold", fill: color,
            label
            + if numbering { " " + number } else { "" }
            + if title != "" { " (" + title + ")" } else { "" }
            + ". "
          )
        }
        body
      })
    )
  }

  figure(
    env-body,
    kind: tag,
    supplement: label,
    numbering: n => context {
      let hs = counter(heading).get()
      let chapter = hs.at(0, default: 0)
      let section = hs.at(1, default: 0)
      str(chapter) + "." + str(section) + "." + str(n)
    },
  )
}

#let theorem(body, title: "")    = _env("theorem",    "定理", c-thm,  title, body)
#let lemma(body, title: "")      = _env("lemma",      "引理", c-prop, title, body)
#let proposition(body, title:"") = _env("proposition","命题", c-prop, title, body)
#let corollary(body, title: "")  = _env("corollary",  "推论", c-prop, title, body)
#let definition(body, title: "") = _env("definition", "定义", c-def,  title, body)
#let axiom(body, title: "")      = _env("axiom",      "公理", c-def,  title, body)
#let example(body, title: "")    = _env("example",    "例",   c-con,  title, body, numbering: false)
#let remark(body, title: "")     = _env("remark",     "注",   c-rem,  title, body, numbering: false)

#let quote(body) = block(
  width: 100%,
  inset: (top: 0.8em, bottom: 0.8em),
  align(center, grid(
    columns: (auto, auto, auto),
    column-gutter: 0.15em,
    align: horizon,
    text(size: 24pt, fill: c-def, "「"),
    body,
    text(size: 24pt, fill: c-def, "」"),
  )),
)

#let proof(body) = block(
  width: 100%, inset: (left: 0pt, right: 0pt, top: 4pt, bottom: 4pt),
  {
    text(style: "italic", fill: muted, "Proof. ")
    body
    h(1fr)
    text(fill: muted, "□")
  }
)

/* defines */

#let rightarrow = $stretch(->, size: #15pt)$
#let movebase(size, x) = text(baseline: size)[#x]
#let injlim = $display(limits(lim_(movebase(#(-1.9pt),rightarrow))))$
#let varinjlim(subscript) = $injlim_movebase(#(-2.8pt), subscript)$

#let leftarrow = $stretch(<-, size: #15pt)$
#let projlim = $display(limits(lim_(movebase(#(-1.9pt),leftarrow))))$
#let varprojlim(subscript) = $projlim_movebase(#(-2.8pt), subscript)$

#let neq(body) = math.equation(
  block: true,
  numbering: "(1)",
  body,
)

#let colim = $op("colim")$
#let Spec = $op("Spec")$

#let Hom = "Hom"
#let Fun = "Fun"
#let Map = "Map"
#let Der = "Der"
#let Aut = "Aut"
#let End = "End"
