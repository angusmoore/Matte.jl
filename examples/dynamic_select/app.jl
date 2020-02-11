module DynamicSelectApp

using Matte

const title = "Dynamic Selection"

function ui()
    sidebar_layout(
        side_panel(
            selector("first_select", "Select First Option:", "['Group #1', 'Group #2']"),
            selector("main_select", "Choose a subgroup", "dynamic_items")
        ),
        main_panel(
            h1("Chosen Sub-group"),
            text_output("subgroup")
        )
    )
end

module Server

function dynamic_items(first_select)
  if (first_select == "Group #1")
    ["Subgroup 1.$i" for i in 1:10]
  elseif (first_select == "Group #2")
    ["Subgroup 2.$i" for i in 1:10]
  else
    ["No group selected"]
  end
end

function subgroup(main_select)
    main_select
end

end

end
