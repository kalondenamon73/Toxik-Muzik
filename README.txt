TOXIK MUSIK — RELEASE PACKAGE (local featured music included)

What's included:
- index.html: mobile-friendly music website with embedded local catalog paths
- music/: 5 user-uploaded MP3 tracks, ready for offline local preview after extracting
- setup.sql: Supabase backend schema, RLS and public storage bucket policies
- This README with deployment checklist

Songs bundled:
1. Naxxy — Toxic
2. Lero Lokha (Demo) — Toxic
3. Freestyle — Toxic
4. Close Enough — Toxic
5. Polota — Toxic

Website functionality:
- Built-in Toxic catalog plays the actual included MP3s
- Search by song/artist, genre filter
- Streaming player controls
- Track share (mobile share sheet or clipboard fallback)
- Download controls (browser behavior may open link rather than save)
- Device-local favorites
- Supabase auth and community upload workflow when configured
- Cover image upload and deep links to tracks
- Responsive layout

CONFIGURE ONLINE COMMUNITY FEATURES:
1. Create a Supabase project.
2. Run setup.sql in its SQL Editor.
3. Open Project Settings > API and copy the Project URL and anon/public key.
4. In index.html, replace YOUR_SUPABASE_URL and YOUR_SUPABASE_ANON_KEY.
   NEVER put the service_role key in frontend HTML.
5. Deploy the folder contents to HTTPS hosting (GitHub Pages, Netlify, etc).

RELEASE CHECKLIST / HONEST LIMITATIONS:
This is a complete static-site starter with local songs, but a truly production-ready
public upload platform needs backend credentials, testing in its deployed origin,
copyright/reporting process, moderation, privacy policy, terms, abuse/rate limits,
secure analytics, backup plan, and storage cost controls. Those are not automatically
activated by this ZIP. Public storage means uploaded tracks can be streamed and downloaded.
The plays count is not implemented as trustworthy analytics. Please test signup,
upload, share, download, mobile playback and file limits before public launch.
