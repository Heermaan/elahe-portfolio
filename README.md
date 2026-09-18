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

Deployed by `.github/workflows/pages.yml` on every push to `main`. **GitHub → Settings → Pages → Source must be "GitHub Actions"** (not "Deploy from a branch"). Add a `CNAME` file with the domain when ready and set `baseurl: ""` in `_config.yml`.

The workflow runs `scripts/build-thumbs.sh` before Jekyll: it makes 800px JPEG + WebP thumbnails of everything in `work/` (grid tiles use those; the lightbox opens the original) and downloads poster images for the videos in `_data/videos.yml`. Both output folders are git-ignored. Run the script locally before `jekyll serve` if you want the same result (uses `sips` on macOS, ImageMagick elsewhere; WebP only where `cwebp` or ImageMagick exists).
