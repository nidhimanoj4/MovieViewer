# Project 2 - Flixsta

Flixsta is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: 12 hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [ ] User sees an error message when there's a networking error.
- [ ] Movies are displayed using a CollectionView instead of a TableView.
- [x] User can search for a movie.
- [x] All images fade in as they are loading.
- [x] User can view the large movie poster in a Detailed View Page by tapping on a cell.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [ ] Customize the selection effect of the cell.
- [ ] Customize the navigation bar.
- [x] Customize the UI.

The following **additional** features are implemented:

- [x] Added an App Icon
- [x] Added icons to the Flixsta logo
- [x] Open Fandango Web View Page to book tickets from a movie's detailed view page
- [x] Scroll View on the detailed view page
- [x] SizeToFit all the text for UI
- [x] Refine and add more data to movie information detail page (release data and rating]
    - Rating data was based on the vote_average data from the API

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. How to smoothly integrate a Collection View that would have the same functionality as the table view
2. Discuss page animation views, such as a slide transition to a detailed page view

## Video Walkthrough

Find Full Video here: http://i.imgur.com/Cv9AGoy.mp4

Here's a walkthrough of implemented user stories:
<img src='http://i.imgur.com/BBH6dnH.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

<img src='http://i.imgur.com/nOGcc4R.gif' title='Video Walkthrough2' width='' alt='Video Walkthrough2' />

<img src='http://i.imgur.com/axftiAM.gif' title='Video Walkthrough2' width='' alt='Video Walkthrough2' />

<img src='http://i.imgur.com/PP2vXsa.gif' title='Video Walkthrough2' width='' alt='Video Walkthrough2' />


GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

The search bar functionality was new and took a while to figure out. Connecting the API was much easier after having implemented the Tumblr client app. The most rewarding improvements of the app were the detailed view page with scrolling and the Fandango Web View Connection. 

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [MBProgressHUD](https://github.com/jdg/MBProgressHUD) - track progress of loading data

## License

    Copyright 2016 Nidhi Manoj

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
