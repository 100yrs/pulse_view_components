console.log("pulse_view_components/application.js starting to load...")

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

// ActiveStorage.start()

console.log("pulse_view_components/application.js loaded")
