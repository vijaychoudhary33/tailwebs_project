import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.modal = this.element;
    this.handleClickOutside = this.handleClickOutside.bind(this);
  }

  openModal() {
    this.modal.classList.remove('hidden');
    document.addEventListener('click', this.handleClickOutside);
  }

  closeModal() {
    this.modal.classList.add('hidden');
    document.removeEventListener('click', this.handleClickOutside);
  }

  handleClickOutside(event) {
    if (!this.modal.contains(event.target)) {
      this.closeModal();
    }
  }
}
