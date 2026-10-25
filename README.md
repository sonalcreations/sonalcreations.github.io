# Sonal Creations Boutique website

Single-page static site for Sonal Creations Boutique, Prakash Nagar, Begumpet, Hyderabad.
Live at https://sonalcreations.workingalien.com/ (GitHub Pages, repo `sonalcreations/sonalcreations.github.io`; `sonalcreations.github.io` redirects there).

No build step. Edit `index.html` and `styles.css` directly, commit, and push to `main`; GitHub Pages publishes within a minute or two.

## Before launch

1. **WhatsApp and phone number.** Set to +91 98494 62143. To change it, replace `919849462143` in every link in one go, then fix the visible `Call +91 ...` label in the Visit section by hand:

   ```bash
   sed -i '' 's/919849462143/91NEWNUMBER/g' index.html
   ```

2. **Photos.** Placeholders are Unsplash images and must be replaced with the boutique's own work. Drop files into `assets/img/` and update the `src` next to each `TODO` comment in `index.html`:

   | File | Size | Where |
   |---|---|---|
   | `hero.jpg` | 1000x1250 | Hero, right side (your single best piece) |
   | `bridal.jpg` | 900x1200 | Collections, large tile |
   | `blouses.jpg` | 900x675 | Collections, blouses tile |
   | `sarees.jpg` | 900x675 | Collections, sarees tile |
   | `work-1.jpg` to `work-6.jpg` | 600x750 | Recent work strip |
   | `og.jpg` | 1200x630 | Link preview on WhatsApp and Instagram (`og:image` and the JSON-LD `image`) |

   Keep JPEGs under about 200 KB each. Also update the `alt` text to describe the real photo.

3. **Instagram.** Replace `sonalcreations.boutique` (footer link and JSON-LD `sameAs`).

4. **Copy to confirm with the owner.** "Alterations on anything we stitch" and "Small adjustments after delivery are part of the service" are promises; soften or remove them if they are not true. The hours table says Mon to Sat 11 AM to 8 PM, Sunday closed, as on Google Maps.

## Showing an offer

In the Offers section of `index.html` there is a commented-out `<div class="offer">`. Remove the comment markers and edit the title, line and validity. To go back to "ask on WhatsApp", comment it out again.

## Languages (English, Telugu, Hindi)

The language picker in the top bar switches the page between English, Telugu and Hindi without reloading. The choice is remembered on that device, and the address bar gains `?lang=te` or `?lang=hi`, so a shared link opens in the same language (for example https://sonalcreations.workingalien.com/?lang=te).

- **English** text lives in `index.html`. Edit it there as before.
- **Telugu and Hindi** text lives at the top of `script.js`, in `I18N.te` and `I18N.hi`. Each key matches a `data-i18n` attribute in `index.html`. A key missing from a language falls back to English.
- **New text that should be translated:** add `data-i18n="someKey"` to the element in `index.html`, then add `someKey` to both `I18N.te` and `I18N.hi`.
- **WhatsApp messages** are translated too (`waStitch`, `waOffers`, `waVisit`), so a Telugu visitor's chat opens with a Telugu message.
- **Not translated on purpose:** the brand name, the street address, the image descriptions (they will change when real photos arrive), and the search-engine description in `<head>`.
- **Fonts:** Telugu and Hindi use Tiro and Noto Sans, self-hosted in `assets/fonts/`. They download only when someone picks that language.

The translations were written for this site and have not been reviewed by a native speaker yet. Have someone fluent in Telugu and Hindi read through `script.js` before promoting the site in those languages.

## Google rating

The line "Rated 5.0 on Google" is hardcoded. Update it if the rating on the Maps listing changes.

## Local preview

```bash
python3 -m http.server 8080 --bind 127.0.0.1
```

Then open http://127.0.0.1:8080/.

## Hosting (GitHub Pages)

The repo `sonalcreations/sonalcreations.github.io` is an organization site, so GitHub Pages serves the `main` branch root. `.nojekyll` tells Pages to publish the files as they are. The `CNAME` file holds the custom domain; at the workingalien.com registrar a CNAME record `sonalcreations` points to `sonalcreations.github.io`, and HTTPS is enforced in the repo's Pages settings. The repo must stay public on the free plan.

Deploy after any edit:

```bash
git add -A && git commit -m "Update site" && git push
```

Check the build under the repo's Actions tab (the "pages build and deployment" workflow) if a change does not show up after a couple of minutes.

The earlier AWS setup (S3 bucket, CloudFront distribution) was removed on 2026-10-21.
