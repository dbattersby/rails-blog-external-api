import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "alerts", "fields", "response" ];

  success() {
    setTimeout(() => {
      if(this.alertsTarget.dataset.errors != "true") {
        this.fieldsTarget.style.display = "none";
        this.responseTarget.innerHTML = "Post has been saved successfully 🎉";
      }
    }, 500);
  }
}