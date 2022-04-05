import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="post"
export default class extends Controller {
  static values = { isEditing: Boolean }
  static targets = [ "body", "edit" ]
  static classes = [ "editing" ]

  toggleEditor(event) {
    event.preventDefault()

    if (this.isEditing) {
      this.isEditingValue = false
      this.element.classList.remove(this.editingClass)
      this.editTarget.text = 'edit'
    } else {
      this.isEditingValue = true
      this.element.classList.add(this.editingClass)
      this.editTarget.text = 'update'
    }
  }
}
