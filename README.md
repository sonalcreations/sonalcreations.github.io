# Sonal Creations Boutique website

Single-page static site for Sonal Creations Boutique, Prakash Nagar, Begumpet, Hyderabad.
Live at https://botique.workingalien.com/ (AWS S3 + CloudFront).

No build step. Edit `index.html` and `styles.css` directly, then run `./deploy.sh`.

## Before launch

1. **WhatsApp and phone number.** Every link uses the placeholder `91XXXXXXXXXX`. Replace it in one go (country code first, no plus, no spaces):

   ```bash
   sed -i '' 's/91XXXXXXXXXX/919876543210/g' index.html
   ```

   Then fix the visible label `Call +91 XXXXX XXXXX` in the Visit section by hand.

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

## Google rating

The line "Rated 5.0 on Google" is hardcoded. Update it if the rating on the Maps listing changes.

## Local preview

```bash
python3 -m http.server 8080 --bind 127.0.0.1
```

Then open http://127.0.0.1:8080/.

## Hosting (AWS, account 135379837669)

One-time setup, already done or to do with the AWS CLI:

- Certificate: the existing `*.workingalien.com` certificate in `us-east-1` (ACM `de50c5f8-2668-44b8-afeb-b43a74abbb6c`) covers this subdomain.
- S3 bucket `botique.workingalien.com` (private, no website hosting) in `ap-south-1`. Done.
- CloudFront distribution `E29F8UJLC7S3R6` (`d395h5e9cnixh2.cloudfront.net`) with Origin Access Control to that bucket, default root object `index.html`, HTTP redirected to HTTPS, alias `botique.workingalien.com`. Done.
- DNS: `workingalien.com` is not in Route 53 in this account. Add this record at the registrar:

  | Type | Name | Value | TTL |
  |---|---|---|---|
  | CNAME | `botique` | `d395h5e9cnixh2.cloudfront.net` | 300 |

Deploy after any edit:

```bash
./deploy.sh
```

It syncs the folder to S3 (excluding git and editor files), sets long cache headers on `assets/` and short ones on HTML, and invalidates the CloudFront cache.
