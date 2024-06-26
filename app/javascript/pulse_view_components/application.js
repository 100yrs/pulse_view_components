import { Application } from "@hotwired/stimulus"
import Dropdown from "stimulus-dropdown"
// import * as ActiveStorage from "@rails/activestorage"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

// application.register("dropdown", Dropdown)

// Automatically load controllers from ViewComponents directory.
import controllers from "../../components/**/*_controller.js"
controllers.forEach(controller => {
  var name = controller.name.replace("..--..--components--", "")
  application.register(name, controller.module.default)
})

export { application }

import { Turbo } from "@hotwired/turbo-rails"
Turbo.StreamActions.redirect = function () {
  Turbo.visit(this.target)
}
Turbo.StreamActions.console_log = function () {
  const message = this.getAttribute("message")
  console.log(message)
}

// ActiveStorage.start()
