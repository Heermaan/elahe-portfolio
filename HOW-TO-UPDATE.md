# How to update your website

No coding needed. Everything on the site comes from a few folders and one settings file.

## Adding pictures or videos

1. Open the `work` folder. Inside are one folder per section of the site:

   | Folder | Shows up on |
   |---|---|
   | `work/featured/` | Home page ("Featured") |
   | `work/motion/` | Motion page |
   | `work/characters/` | Characters page |
   | `work/illustration/` | Illustration page |
   | `work/3d/` | 3D page |

2. Drop your file into the right folder. That's it.

**File types that work:** `.jpg` `.png` `.gif` `.webp` `.mp4` `.webm`

**Naming your files** (this controls the order and the caption):

```
01-red-fox.jpg        →  shows first, caption "Red fox"
02-forest-queen.png   →  shows second, caption "Forest queen"
10-storyboard.jpg     →  shows later
```

- Start with a number to set the order. Lower numbers show first.
- Use dashes instead of spaces.
- Keep filenames in English letters and numbers only. No spaces, no Farsi.
- Each image should be under about 2 MB. Short video loops under about 10 MB.

**Featured** is the home page. Put copies of your 6 best pieces there. Same file can live in two folders, that's fine.

## Adding a YouTube video

Open `_data/videos.yml`. Under the section name, add a line with the YouTube link:

```
motion:
  - https://youtu.be/IZJlqanhGVo
  - https://youtu.be/YOUR-NEW-VIDEO
```

Two spaces, a dash, a space, then the link. Videos appear above the images on that page.

## Changing text

- **Your bio:** open `about/index.md` and edit the text.
- **Name, tagline, email, LinkedIn:** open `_config.yml` and edit the words inside the quotes.

## Changing the hero video (top of home page)

Either change the `hero_video` link in `_config.yml`, or save a video file as `assets/hero.mp4`. If that file exists it's used instead of YouTube and looks cleaner.

## Removing something

Delete the file from the folder. Gone from the site.

## The placeholder files

The coloured squares that say "RED FOX" etc. are placeholders. Delete every `placeholder-*.svg` file once your real work is in.

## Where to do all this

On GitHub, open the folder, click **Add file → Upload files**, drag your files in, click **Commit changes**. The site updates itself in about a minute.
