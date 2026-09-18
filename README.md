# Elahe Afroozan — portfolio

Static Jekyll site for GitHub Pages. Zero plugins, zero build tooling beyond what Pages runs itself.

**Non-technical maintainer guide:** [HOW-TO-UPDATE.md](HOW-TO-UPDATE.md)

## How it works

- `work/<category>/` — drop media files in; `_includes/gallery.html` lists every image/video via `site.static_files`, sorted by filename. Leading number prefix sets order and is stripped from the caption.
- `_data/videos.yml` — YouTube links per category, embedded above the grid.
- `_config.yml` — site text, contact links, category list (order, slug, tile shape).
- `assets/hero.mp4` — optional. If present, replaces the looping YouTube hero.
- `assets/portrait.jpg` — optional. Shown on About.
- `assets/css/style.css` — first block of `:root` variables restyles everything.

## Local preview

```
bundle install
bundle exec jekyll serve
```

Then open http://localhost:4000

## Deploy

Push to GitHub → Settings → Pages → Deploy from branch `main`, folder `/ (root)`. Add a `CNAME` file with the domain when ready.
