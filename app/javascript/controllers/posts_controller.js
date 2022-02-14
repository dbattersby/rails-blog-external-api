import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "fields", "response" ];

  success() {
    this.fieldsTarget.style.display = "none";
    this.responseTarget.innerHTML = "Post has been saved successfully! 🎉";
  }
}