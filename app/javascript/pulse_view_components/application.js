import { Application } from "@hotwired/stimulus"
import Dropdown from "stimulus-dropdown"
import * as Turbo from "@hotwired/turbo"

import TurboPower from "turbo_power"
TurboPower.initialize(Turbo.StreamActions)

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
