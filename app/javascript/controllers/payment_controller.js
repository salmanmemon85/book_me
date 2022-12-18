import { Controller } from "@hotwired/stimulus"
let payelement = document.querySelector('#payelement')
let elements
const csrfToken = document.getElementsByName("csrf-token")[0].content
// const stripe = document.getElementsByName("stri`pe-public-key")[0].content
export default class extends Controller {
  static values = {
    item: String,
    returnURl: String
  }
  static targets = ["payelement", "submit", "form", "name", "email"]
    connect() {
      console.log(payelement)
    }
  async initialize() {
    const response = await fetch("/payment-intent",{
        method: "POST",
        headers: {
            "X-CSRF-Token": csrfToken,
            "Content-Type": "application/json",
            Accept: "application/json",
        },
        body: JSON.stringify(this.itemValue)
    })
    const {clientSecret} = await response.json()
    const appearance = {
        theme: "stripe"
    }
    elements = stripe.elements({
        appearance,clientSecret
    })
    const paymentElement = elements.create("payment")
    paymentElement.mount(payelement)
  }
  async purchase(event){
    event.preventDefault()

    this.setLoading(true)
    const {error} = await stripe.confirmPayment({
      elements,
      redirect: "if_required"
    })
    if (error) {
      if (error.type === "card_error" || error.type == "validation_error") {
        this.showMessage(error.message)
      }
      else {
        this.showMessage("an unexpected error accurd   ")
      }
    }
    else {
      this.formTarget.submit()
      this.setLoading(false)
    }
  }

  setLoading(isloading){
    if (isloading) {
      this.submitTarget.disabled = true
      this.submitTarget.classList.add("opacity-50")
      this.submitTarget.value = "Proceeed....."
    }
    else {
      this.submitTarget.disabled = false
      this.submitTarget.classList.add("opacity-50")
      this.submitTarget.value = "Schedule Booking"
    }
  }
  showMessage(messageText){
    this.messageTarget.classList.remove("hidden")
    this.messageTarget.textContent = messageText
    setTimeout(() => {
      this.messageTarget.classList.add("hidden")
    this.messageTarget.textContent = ""
    }, 4000);
  }
}
