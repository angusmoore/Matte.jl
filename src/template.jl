retrieve_content(content::UIElement) = content.html

function retrieve_content(content::NTuple{N, UIElement}) where N
    out = ""
    for c in content
        out *= c.html
    end
    out
end

ui_input_js(content::UIElement) = content.model

function ui_input_js(content::NTuple{N, UIElement}) where N
    join(["error_snackbar: false,\nmatte_error_msg: \"\"", skipmissing([x.model for x in content])...], ",\n")
end

function unroll(content::Tuple)
    out = ()
    for c in content
        if typeof(c) <: UIElement
            out = (out..., c)
        elseif typeof(c) <: AbstractString
            out = (out..., UIElement(c))
        else
            out = (out..., unroll(c)...)
        end
    end
    out
end

function template_content(title, content)
"""
<v-app id="inspire">
    <div>
        <v-app-bar
        color="indigo darken-4"
        dark>
        <v-toolbar-title>
            $title
        </v-toolbar-title>
        <v-spacer></v-spacer>
    </div>
</v-app-bar>
<v-content>
$(retrieve_content(unroll(content)))
</v-content>"""
end

function generate_template(title, ui, server_module)
"""
<!DOCTYPE html>
<html>
<head>
  <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/@mdi/font@4.x/css/materialdesignicons.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/vuetify@2.x/dist/vuetify.min.css" rel="stylesheet">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
  <title>$title</title>
</head>
<body>
<div id="app">
$(template_content(title, ui()))

<v-snackbar
      v-model="error_snackbar"
      color = "error"
      :timeout="10000"
    >
      {{ matte_error_msg }}
      <v-btn
        text
        @click="error_snackbar = false"
      >
        Close
      </v-btn>
    </v-snackbar>
</div>
<script src="https://cdn.jsdelivr.net/npm/vue@2.x/dist/vue.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vuetify@2.x/dist/vuetify.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>
new Vue({
  el: '#app',
  vuetify: new Vuetify(),
  data: {
    $(ui_input_js(unroll(ui())))
  },
  $(generate_output_js(server_module))
})
</script>
</body>
</html>
"""
end