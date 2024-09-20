// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
import CustomerController from "./customer_controller"
application.register("customer", CustomerController)
import ModalController from "./modal_controller"
application.register("modal", ModalController)