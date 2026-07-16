# AG

Typst + zathura watch:

```sh
./watch-typst-zathura.sh
```

The script compiles `AG1.typ` into a temporary PDF first, then atomically
replaces `AG1.pdf` only after the temporary file is stable. This avoids zathura
reloading a half-written PDF, which is a common reason for jumping back to the
first page after each update.

You can also pass explicit paths:

```sh
./watch-typst-zathura.sh AG1.typ AG1.pdf
```
