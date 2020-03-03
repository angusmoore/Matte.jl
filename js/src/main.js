// ./src/main.js

import Vue from 'vue'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import './config.js'
import './matte.js'

Vue.use(Vuetify)

const opts = {}

export default new Vuetify(opts)

// Make Vue and Vuetify available globally, so our Matte-generated HTML can access
window.Vue = Vue;
window.Vuetify = Vuetify;
