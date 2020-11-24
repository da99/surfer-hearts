import { getAssetFromKV } from "@cloudflare/kv-asset-handler"

addEventListener('fetch', event => {
  event.respondWith(handleRequest(event))
})

/**
 * Respond with hello worker text
 * @param {Request} request
 */
async function handleRequest(request) {
  try {
    return await getAssetFromKV(request)
  } catch (e) {
    let x = "<html><head><title>Come back in a few days...</title></head><body>This page is not ready.</body></html>";
    return new Response(x, {
      headers: { 'content-type': 'text/plain' },
      status: 404,
      status_text: "not found"
    })
  } // try catch
} // function
