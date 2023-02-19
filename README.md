# Project: Global Animal Sightings

App for searching animal sightings in various countries. Created by: Brennan Larson. Email: BrennanLarson@protonmail.com.
The app can be accessed [here](https://zzz-polished-a3181562-86b4-4a27-9e71-5a8e483b1b19-amai4lhqja-ue.a.run.app).
## Project Description

App utilizes all animal sightings from all countries listed by the Global Biodiversity Information Facility. When someone searches for an animal in the app, a map display where the animal was seen and shows a timeline of how many times the animal was seen on various days.

## How to access the app
The Global Animal Sightings app can be access [here](https://zzz-polished-a3181562-86b4-4a27-9e71-5a8e483b1b19-amai4lhqja-ue.a.run.app).
## How to use the app
The app requires users to input an animal they want to search for in the search bar and select what country they want to look for the animal in.
## Development Notes

### Business requirements
1: App allows for search of animals by vernacular and scientific name.\
2: App display a visualization timeline of when a given animal was seen.\
3: App display a default screen instructing a user to type in an animal in the search bar.\
4: There are some additional features added in to make the app more user friendly. These are \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1: Allowing users to search by a general vernacular name, eg bear. \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2: Non case specific text required for matching user search with vernacular or scientific name.
    I lower all text. \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3: If there are multiple animals found that match what the user is looking for, \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    all of them are displayed on the map and timeline. This is good because if \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    a user is looking for a vauge animal like a bear, then multiple bears found in that \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    country will be first displayed, then the user can narrow their bear search down \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    from there.


### Technical requirements
1: No scaffolding tools like Golem, packer, were used for development.\
2: shinyModules have been used on the UI page of the app. The server page for the app could likely use some modules as well for a future update to the app.\
3: Unit test was performed via the shinytest2 package. Tests can be found in the "tests" folder.

### Add-on Features/Extras
1: Beautiful UI skill: CSS is used extensively throughout the app to give the header, footer, buttons, graph timeline, and map a more pleasant and unique look. \
\
2: Performance optimization skill: The initial huge dataset csv file of 20GB was broken down into individual country csv files using Python, and then stored on AWS S3. Then these countries csv files are called in the app to create the dataframes. This results in super quick speeds and allows for all countries to be included in the analysis.\
\
3: JavaScript skill: When an animal name is click on the map, then the animal's scientific name will be displayed.\
\
4: Infrastructure skill: App utilizes AWS 3 for file storage and retrieval, and Polished Hosting for custom deployment, thus not utilizing shinyapps.io.

### Future improvements
The biggest future improvement would likely be with utilizing shiny modules more in the server section of the app. They are used in the UI portion of the app to create a cleaner look, since adding in HTML and CSS can get messy quick and the modules create nice structure regarding how the code looks for code review.
