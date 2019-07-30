// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket,
// and connect at the socket path in "lib/web/endpoint.ex".
//
// Pass the token on params as below. Or remove it
// from the params if you are not using authentication.
import {Socket} from 'phoenix'

let socket = new Socket('/socket', {params: {token: window.userToken}})
socket.connect()

let match = document.location.pathname.match(/\/items\/(\d+)$/)

if (match) {
  let itemId = match[1]
  let channel = socket.channel(`item:${itemId}`, {})

  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })

  channel.on('new_bid', data => {
    const elm  = document.getElementById('bids')
    elm.insertAdjacentHTML("afterbegin", data.body)
  })
}

export default socket
