function sidebar_layout(sidepanel, mainpanel)
UIElement("""
<v-container cols = "12">
    <v-row>
        <v-col cols = "4">
            <v-card>
                <v-card-text>""", missing),
                sidepanel,
                UIElement("""
                </v-card-text>
            </v-card>
        </v-col>
        <v-col cols = "8">
            <v-card>
                <v-card-text>""", missing),
                mainpanel,
                UIElement("""</v-card-text>
            </v-card>
        </v-col>
    </v-row>
</v-container>
""", missing)
end

struct TabPanel
    title::String
    content::Union{UIElement, NTuple{N, UIElement}} where N
end

function tabs_layout(tabs...; vertical = false)

    start = UIElement("""
    <v-tabs
      background-color="deep-purple accent-4"
      centered>""")

    tab_buttons = [UIElement("""<v-tab >$(tab.title)</v-tab>""") for (i, tab) in enumerate(tabs)]

    tab_content = ()
    for (i, tab) in enumerate(tabs)
        tab_content = (tab_content..., UIElement("""<v-tab-item>
          <v-card>"""), tab.content,
          UIElement("""</v-card></v-tab-item>"""))
    end

    (start, tab_buttons..., tab_content, UIElement("</v-tabs>"))
end


function tab_panel(title, content)
    TabPanel(title, unroll(content))
  end
