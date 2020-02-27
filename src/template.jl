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
    watch = extract_uitype(UIWatch, unrolled)

    dep_tree = dependency_tree(server_module)
    rev_dep = reverse_dependency_tree(server_module)

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
  <link href="https://cdn.jsdelivr.net/npm/@mdi/font@4.x/css/materialdesignicons.min.css" rel="stylesheet">
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
    <v-overlay :value="matte_notconnected_overlay">
        <div class="text-center">
        <v-progress-circular
          indeterminate
          color="primary"
        ></v-progress-circular>
        </div>
    </v-overlay>
</v-app>
</div>
<script src="/bundle.min.js"></script>
<script>
session_id = "$(UUIDs.uuid1())";
$(vue_js(rev_dep, dep_tree, models, watch))
</script>
</body>
</html>
"""
end
