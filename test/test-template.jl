stripws(str) = replace(str, " " => "")

@test stripws(Matte.generate_template("")) == stripws("""
<div id="app">
    <v-app id="inspire">
        <div>
            <v-app-bar
            color="indigo darken-4"
            dark>
            <v-toolbar-title>
                Page title
            </v-toolbar-title>
            <v-spacer></v-spacer>
        </div>
    </v-app-bar>
    <v-content>

    </v-content>
</div>""")

@test stripws(Matte.tabset_panel("", "")) == stripws("""
<v-container cols = "12">
    <v-row>
        <v-col cols = "4">
            <v-card>
                <v-card-text>

                </v-card-text>
            </v-card>
        </v-col>
        <v-col cols = "8">
            <v-card>
                <v-card-text>

                </v-card-text>
            </v-card>
        </v-col>
    </v-row>
</v-container>
""")
