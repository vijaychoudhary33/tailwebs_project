import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="customer"
export default class extends Controller {
  initialize() {
    this.element.setAttribute("data-action", "click->customer#click")
  }

  click(e) {
    e.preventDefault()
    this.url = this.element.getAttribute("href")
    fetch(this.url, {
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
    .then(r => r.text())
    .then(html => Turbo.renderStreamMessage(html))
  }
}
