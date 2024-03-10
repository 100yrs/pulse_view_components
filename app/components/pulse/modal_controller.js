import { Controller } from "@hotwired/stimulus"
import { enter, leave } from "el-transition"

// Connects to data-controller="pulse--modal"
export default class extends Controller {
  static targets = ["wrapper", "body"]
  static values = {
    closeOnEsc: { type: Boolean, default: true },
    closeOnSubmit: { type: Boolean, default: true },
    autoClose: { type: Boolean, default: false },
  }

  connect() {
    console.log("pulse--modal connected")
    if (!this.autoCloseValue) {
      document.addEventListener("keydown", this.handleKeyDown)

      if (this.closeOnSubmitValue) {
        document.addEventListener("turbo:submit-end", this.handleSubmit)
      }
      this.open()
    } else {
      this.autoClose()
    }
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleKeyDown)

    if (this.closeOnSubmitValue) {
      document.removeEventListener("turbo:submit-end", this.handleSubmit)
    }
  }

  handleKeyDown = e => {
    if (this.closeOnEscValue && e.key === "Escape") {
      e.stopPropagation()
      this.close()
    }
  }

  open() {
    enter(this.wrapperTarget)
    enter(this.bodyTarget)
    document.body.classList.add("pulse-overflow-hidden")
  }

  close(e) {
    leave(this.wrapperTarget)
    leave(this.bodyTarget).then(() => {
      // Remove the modal element after the fade out so it doesn't blanket the
      // screen
      this.element.remove()
    })

    document.body.classList.remove("pulse-overflow-hidden")

    // Remove src reference from parent frame element
    // Without this, turbo won't re-open the modal on subsequent clicks
    this.element.closest("turbo-frame").src = undefined
  }

  autoClose(e) {
    this.element.remove()
    document.body.classList.remove("pulse-overflow-hidden")
  }

  handleSubmit = e => {
    if (e.detail.success) {
      this.close()
    }
  }
}
