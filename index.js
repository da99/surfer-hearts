addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
})
/**
 * Respond with hello worker text
 * @param {Request} request
 */
async function handleRequest(request) {
  let x = "<html><head><title>Come back in a few days...</title></head><body>Not ready. []]]</body></html>";
  return new Response(x, {
    headers: { 'content-type': 'text/html' },
    status: 200
  })
}
