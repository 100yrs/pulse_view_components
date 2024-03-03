import { Controller } from "@hotwired/stimulus"
import { enter, leave } from "el-transition"

// Connects to data-controller="pulse--toast"
export default class extends Controller {
  static values = {
    autoHide: { type: Boolean, default: true },
    autoHideDuration: { type: Number, default: 3000 },
  }

  connect() {
    enter(this.element)

    if (this.autoHideValue) {
      this.autoHideTimeout = setTimeout(() => {
        this.dismiss()
      }, this.autoHideDurationValue)
    }
  }

  disconnect() {
    if (this.autoHideValue) {
      clearTimeout(this.autoHideTimeout)
    }
  }

  dismiss() {
    leave(this.element).then(() => {
      this.element.remove()
    })
  }
}
