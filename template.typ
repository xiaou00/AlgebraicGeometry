// ─────────────────────────────────────────────
//  Math Notes Template
// ─────────────────────────────────────────────

#let ink    = rgb("#111827")        // near-black for headings & title
#let muted  = rgb("#64748b")       // secondary text
#let rule-c = rgb("#d1d5db")       // light gray for decorative lines

// environment colors
#let c-thm  = rgb("#4d7f9d")       // theorem
#let c-def  = rgb("#b45a5a")       // definition — muted red
#let c-prop = rgb("#4d7f9d")       // proposition / lemma / corollary
#let c-con  = rgb("#4f937f")       // example — muted teal
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

#let _heading-chip(
  number,
  title,
  fs: 13pt,
  hgt: 20pt,
  slant: 7pt,
  pad-x: 8pt,
  number-fill: muted,
  title-fill: muted.lighten(32%),
) = context {
  let number-text = text(size: fs, weight: "bold", fill: white, number)
  let title-text = text(size: fs, weight: "bold", fill: white, title + " ")
  let number-w = measure(number-text).width + 2 * pad-x
  let title-w = measure(title-text).width + 2 * pad-x

  box(width: number-w + title-w + slant, height: hgt, {
    place(left + top, polygon(
      fill: number-fill,
      (0pt, 0pt),
      (number-w + slant, 0pt),
      (number-w, hgt),
      (0pt, hgt),
    ))
    place(left + top, dx: number-w, polygon(
      fill: title-fill,
      (slant, 0pt),
      (title-w + slant, 0pt),
      (title-w, hgt),
      (0pt, hgt),
    ))
    place(left + horizon, dx: pad-x, number-text)
    place(left + horizon, dx: number-w + slant + pad-x, title-text)
  })
}

#let _heading-chip-strong(number, title) = context {
  let fs = 20pt
  let hgt = 31pt
  let slant = 10pt
  let pad-x = 11pt
  let white-w = 4pt
  let tail-w = 8pt
  let number-text = text(size: fs, weight: "bold", fill: white, number)
  let title-text = text(size: fs, weight: "bold", fill: white, title + " ")
  let number-w = measure(number-text).width + 2 * pad-x
  let title-w = measure(title-text).width + 2 * pad-x
  let title-x = number-w + white-w
  let tail-x = title-x + title-w + white-w

  box(width: tail-x + tail-w + slant, height: hgt, {
    place(left + top, polygon(
      fill: muted,
      (0pt, 0pt),
      (number-w + slant, 0pt),
      (number-w, hgt),
      (0pt, hgt),
    ))
    place(left + top, dx: number-w, polygon(
      fill: white,
      (slant, 0pt),
      (white-w + slant, 0pt),
      (white-w, hgt),
      (0pt, hgt),
    ))
    place(left + top, dx: title-x, polygon(
      fill: muted.lighten(32%),
      (slant, 0pt),
      (title-w + slant, 0pt),
      (title-w, hgt),
      (0pt, hgt),
    ))
    place(left + top, dx: title-x + title-w, polygon(
      fill: white,
      (slant, 0pt),
      (white-w + slant, 0pt),
      (white-w, hgt),
      (0pt, hgt),
    ))
    place(left + top, dx: tail-x, polygon(
      fill: muted.lighten(48%),
      (slant, 0pt),
      (tail-w + slant, 0pt),
      (tail-w, hgt),
      (0pt, hgt),
    ))
    place(left + horizon, dx: pad-x, number-text)
    place(left + horizon, dx: title-x + slant + pad-x, title-text)
  })
}

#let _heading-chip-title(title) = context {
  let fs = 20pt
  let hgt = 31pt
  let slant = 10pt
  let pad-x = 11pt
  let white-w = 4pt
  let tail-w = 8pt
  let title-text = text(size: fs, weight: "bold", fill: white, title + " ")
  let title-w = measure(title-text).width + 2 * pad-x

  box(width: title-w + white-w + tail-w + slant, height: hgt, {
    place(left + top, polygon(
      fill: muted,
      (0pt, 0pt),
      (title-w + slant, 0pt),
      (title-w, hgt),
      (0pt, hgt),
    ))
    place(left + top, dx: title-w, polygon(
      fill: white,
      (slant, 0pt),
      (white-w + slant, 0pt),
      (white-w, hgt),
      (0pt, hgt),
    ))
    place(left + top, dx: title-w + white-w, polygon(
      fill: muted.lighten(32%),
      (slant, 0pt),
      (tail-w + slant, 0pt),
      (tail-w, hgt),
      (0pt, hgt),
    ))
    place(left + horizon, dx: pad-x, title-text)
  })
}

#let _heading-arrow(number) = context {
  let fs = 11pt
  let hgt = 14pt
  let arrow = 7pt
  let pad-x = 6pt
  let number-text = text(size: fs, weight: "bold", fill: white, number)
  let number-w = measure(number-text).width + 2 * pad-x

  box(width: number-w + arrow, height: hgt, {
    place(left + top, polygon(
      fill: muted,
      (0pt, 0pt),
      (number-w, 0pt),
      (number-w + arrow, hgt / 2),
      (number-w, hgt),
      (0pt, hgt),
    ))
    place(left + horizon, dx: pad-x, number-text)
  })
}

#let _reset-env-counters() = {
  for tag in ("theorem", "lemma", "corollary", "proposition", "definition", "axiom") {
    _env-counter(tag).update(0)
  }
}

#let _env-labels = (
  "env-theorem": "定理",
  "env-lemma": "引理",
  "env-corollary": "推论",
  "env-proposition": "命题",
  "env-definition": "定义",
  "env-axiom": "公理",
)

#let _env-ref(it) = {
  let el = it.element
  if el != none and repr(el.func()) == "block" and repr(el.body.func()) == "align" {
    let inner = el.body.body
    if repr(inner.func()) == "sequence" and inner.children.len() > 0 {
      let first = inner.children.first()
      if repr(first.func()) == "counter-update" and first.has("key") and first.key in _env-labels {
        let hs = counter(heading).at(el.location())
        let chapter = hs.at(0, default: 0)
        let section = hs.at(1, default: 0)
        let n = counter(first.key).at(el.location()).first() + 1
        let number = str(chapter) + "." + str(section) + "." + str(n)
        link(el.location(), _env-labels.at(first.key) + " " + number)
      } else {
        it
      }
    } else {
      it
    }
  } else {
    it
  }
}

// ── Page setup ───────────────────────────────
#let conf(
  title:    "",
  subtitle: "",
  author:   "",
  date:     "",
  easy:     false,
  doc,
) = {
  let header-after = if easy { 0 } else { 2 }

  set page(
    paper:        "a4",
    margin:       (x: 3cm, top: 2.8cm, bottom: 2.5cm),
    header: context {
      if counter(page).get().first() > header-after {
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

  show math.equation: set text(font: ("Libertinus Math", "LXGW WenKai Screen" ) )

  set par(justify: true, leading: 0.75em, spacing: 1.1em)

  show ref: _env-ref

  // fake bold for CJK fonts that lack a bold variant
  show strong: it => text(stroke: 0.35pt + black, weight: "bold", it)

  set math.equation(numbering: none)

  set heading(numbering: "1.1")

  // headings
  show heading.where(level: 1): it => {
    _reset-env-counters()
    pagebreak(weak: true)
    v(0.9em)
    _heading-chip-strong(counter(heading).display("1"), it.body)
    v(0.5em)
  }
  show heading.where(level: 2): it => {
    v(0.75em)
    _heading-chip(counter(heading).display("1.1"), it.body)
    v(0.35em)
  }
  show heading.where(level: 3): it => {
    v(0.55em)
    context grid(
      columns: (auto, auto),
      column-gutter: 7pt,
      align: horizon,
      _heading-arrow(counter(heading).display("1.1.1")),
      text(size: 11pt, weight: "semibold", fill: ink, it.body),
    )
    v(0.15em)
  }

  // ── title block ──────────────────────────────
  if not easy {
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
      _heading-chip-title("目录")
      v(0.8em)
      outline(
        title: none,
        indent: 1.5em,
        depth: 2,
      )
    }

    pagebreak()
  }

  doc
}

// ── Theorem environments ──────────────────────

#let _env(tag, label, color, title, body, numbering: true) = {
  let cnt = _env-counter(tag)
  block(
    width:   100%,
    breakable: true,
    inset:   (left: 12pt, right: 12pt, top: 9pt, bottom: 9pt),
    radius:  0pt,
    fill:    white,
    stroke:  (left: 3pt + color),
    align(left, {
      if numbering { cnt.step() }
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
  numbering: "(I)",
  body,
)

#let colim = $op("colim")$
#let Spec = $op("Spec")$

#let act = $arrow.half.cw$

#let etale = "ét"

#let Hom = "Hom"
#let Fun = "Fun"
#let Map = "Map"
#let Der = "Der"
#let Aut = "Aut"
#let End = "End"
#let Lan = "Lan"
#let Ran = "Ran"
#let Pic = "Pic"
#let Ext = "Ext"
#let Tor = "Tor"
#let op = "op"

#let Set = $bold(sans("Set"))$
#let PSh = $bold(sans("PSh"))$
#let Sh = $bold(sans("Sh"))$
#let Ab = $bold(sans("Ab"))$
#let Mod = $bold(sans("Mod"))$
#let QCoh = $bold(sans("QCoh"))$
#let Grp = $bold(sans("Grp"))$
#let Sch = $bold(sans("Sch"))$
#let Top = $bold(sans("Top"))$
#let Aff = $bold(sans("Aff"))$
#let Cat = $bold(sans("Cat"))$
#let cat(name) = $bold(sans(name))$
