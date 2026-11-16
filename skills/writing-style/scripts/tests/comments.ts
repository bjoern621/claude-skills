// Holds the sync state, and the worker reads it.
const url = "https://example.com/a, and b"; // The worker reads it; it retries.
const s = `line one, and
// not a comment, and still the string
done`;
/**
 * Retries once, so the queue drains.
 * Retries a few times - then stops.
 */
// eslint-disable-next-line no-console -- the log, and its reader
// TODO: retry
// TODO(#12): retry
const t = 'a // b, and c';
