// ./src/main.js

import Vue from 'vue'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import './config.js'
import './matte.js'
import { v1 as uuidv1 } from 'uuid';

Vue.use(Vuetify)

const opts = {}

export default new Vuetify(opts)

// Make Vue and Vuetify available globally, so our Matte-generated HTML can access
window.Vue = Vue;
window.Vuetify = Vuetify;
window.uuidv1 = uuidv1;
