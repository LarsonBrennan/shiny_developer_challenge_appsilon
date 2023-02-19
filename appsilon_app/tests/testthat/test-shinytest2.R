library(shinytest2)

test_that("{shinytest2} recording: appsilon_app", {
  app <- AppDriver$new(name = "appsilon_app", height = 814, width = 847)
  app$set_inputs(`plotly_afterplot-A` = "\"animal_observation_timeline\"", allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":393.5,\"height\":400}", allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(mymap_bounds = c(89.9273232512581, 382.5, -89.9273232512581, -382.5), 
      allow_no_input_binding_ = TRUE)
  app$set_window_size(width = 1207, height = 924)
  app$set_inputs(`plotly_afterplot-A` = "\"animal_observation_timeline\"", allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":573.5,\"height\":400}", allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(mymap_bounds = c(89.9273232512581, 343.125, -89.9273232512581, -343.125), 
      allow_no_input_binding_ = TRUE)
  app$set_window_size(width = 1096, height = 924)
  app$set_inputs(`plotly_afterplot-A` = "\"animal_observation_timeline\"", allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":518,\"height\":400}", allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(searchText = "owl")
  app$set_inputs(searchText = "bird")
  app$set_inputs(searchText = "owl")
  app$set_inputs(searchText = "")
  app$set_inputs(continent = "Europe")
  app$set_inputs(country = "Poland")
  app$set_inputs(searchText = "elk")
  app$set_inputs(continent = "North America")
  app$set_inputs(country = "Canada")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":1,\"pointNumber\":4,\"x\":18098,\"y\":8}]", 
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(searchText = "american elk")
  app$expect_values()
  app$expect_values()
})


test_that("{shinytest2} recording: appsilon_app_test_2", {
  app <- AppDriver$new(variant = platform_variant(), name = "appsilon_app_test_2", 
      height = 969, width = 1096)
  app$set_inputs(`plotly_afterplot-A` = "\"animal_observation_timeline\"", allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":518,\"height\":400}", allow_no_input_binding_ = TRUE, 
      priority_ = "event")
  app$set_inputs(searchText = " ")
  app$set_inputs(searchText = "")
  app$set_inputs(searchText = "owl")
  app$set_inputs(searchText = "owllion")
  app$set_inputs(searchText = "lion")
  app$set_inputs(country = "Tanzania")
  app$set_inputs(continent = "Europe")
  app$set_inputs(country = "Finland")
  app$set_inputs(searchText = "elk")
  app$set_inputs(searchText = "")
  app$set_inputs(searchText = "e")
  app$set_inputs(searchText = "european ")
  app$set_inputs(searchText = "european elk")
  app$set_inputs(searchText = "bear")
  app$set_inputs(searchText = "brown bear")
  app$set_inputs(continent = "North America")
  app$set_inputs(country = "United States")
  app$set_inputs(searchText = "black ")
  app$set_inputs(searchText = "black bear")
  app$set_inputs(searchText = "american blea")
  app$set_inputs(searchText = "american black ")
  app$set_inputs(searchText = "american black bear")
  app$set_inputs(searchText = "bird")
  app$set_inputs(searchText = "b")
  app$set_inputs(searchText = "bear")
  app$set_inputs(mymap_marker_mouseover = c(0.99512524895517, 22.23003300575, -159.40223636921), 
      allow_no_input_binding_ = TRUE)
  app$set_inputs(mymap_marker_mouseout = c(0.878730376051297, 22.23003300575, -159.40223636921), 
      allow_no_input_binding_ = TRUE)
  app$set_inputs(mymap_marker_mouseover = c(0.425309777946201, 35.61303809, -83.48966074), 
      allow_no_input_binding_ = TRUE)
  app$set_inputs(mymap_marker_mouseout = c(0.320120275953178, 35.61303809, -83.48966074), 
      allow_no_input_binding_ = TRUE)
  app$expect_values()
  app$expect_screenshot()
})
