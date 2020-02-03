ui_models(m::UIModel) = "$(m.id): $(m.default)"

function ui_models(content::NTuple{N, UIModel}) where N
    join(["session_id: \"$(UUIDs.uuid1())\",\nerror_snackbar: false,\nmatte_error_msg: \"\"", [ui_models(x) for x in content]...], ",\n")
end

convert_html(content::AbstractUIHTMLElement) = content.html

function convert_html(content::NTuple{N, E}) where {N, E <: AbstractUIHTMLElement}
    join(map(c -> convert_html(c), content), "")
end

function default_header(title)
    UIHeader("""
<div>
<v-app-bar
color="indigo darken-4"
dark>

        <v-toolbar-title>
            $title
        </v-toolbar-title>
        <v-spacer></v-spacer>
</v-app-bar>
</div>
    """)
end

function generate_template(title, ui, server_module)
    unrolled = unroll(ui())
    header = extract_uitype(UIHeader, unrolled)
    footer = extract_uitype(UIFooter, unrolled)
    content = extract_uitype(UIElement, unrolled)
    models = extract_uitype(UIModel, unrolled)

    if length(header) == 0
        header = default_header(title)
    end

    header = convert_html(header)
    footer = convert_html(footer)
    content = convert_html(content)
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
<v-app>
$header
<v-content>
$content
</v-content>
$footer
    <v-snackbar
        v-model="error_snackbar"
        color = "error"
        :timeout="10000">
            {{ matte_error_msg }}
            <v-btn
            text
            @click="error_snackbar = false">
                Close
            </v-btn>
    </v-snackbar>
</v-app>
</div>
<script src="https://cdn.jsdelivr.net/npm/vue@2.x/dist/vue.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vuetify@2.x/dist/vuetify.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>
g = new Vue({
  el: '#app',
  vuetify: new Vuetify(),
  data: {
    $(ui_models(models))
  },
  $(generate_output_js(server_module))
})
</script>
</body>
</html>
"""
end
