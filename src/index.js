import { Elm } from './Main.elm'
import { loginWithKeeper, loginWithSigner } from '@lombardini.io/interactions'

document.addEventListener("DOMContentLoaded", function () {
  const app = Elm.Main.init({
    node: document.getElementById('root')
  })

  app.ports.loginWithKeeper.subscribe(function (msg) {
    console.log('loginWithKeeper port')
    loginWithKeeper().then(x => {
      const address = x.address
      app.ports.toElm.send(address)
    })
  })

  app.ports.loginWithSigner.subscribe(function (loginType) {
    console.log('loginWithSigner port')
    loginWithSigner(loginType).then(x => {
      const address = x.address
      app.ports.toElm.send(address)
    })
  })
})
