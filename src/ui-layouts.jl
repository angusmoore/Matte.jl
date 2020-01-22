 function sidebar_layout(sidepanel, mainpanel)
unroll((UIElement("""
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
""", missing)))
end
