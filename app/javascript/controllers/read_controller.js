import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    $.ajax("/notifications/mark_as_read",{
        dataType: "json",
        type: "POST"
    })    
  }
}
