# Firestore data model

Every signed-in user owns exactly one document at `users/{uid}`. The app writes
library entries as maps keyed by the TMDB ID, which makes adding or removing a
single item atomic and avoids duplicating the full library list.

```text
users/{uid}
  schemaVersion: 2
  profile:
    id, email, name, createdAt, updatedAt
  library:
    favorites:
      movies: { "603": { poster data } }
      tvSeries: { "1396": { poster data } }
    toWatch:  { movies: {}, tvSeries: {} }
    watched:  { movies: {}, tvSeries: {} }
    watchNow: { movies: {}, tvSeries: {} }
```

Firestore's local persistence is enabled, so writes made offline are queued on
the device and synchronized after connectivity returns. Existing documents that
used the old top-level collection fields are migrated to schema version 2 on
their next sign-in.
