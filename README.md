# Flutter Article Reader

A Flutter app that fetches and displays a list of articles from a public
API.

## Getting Started

 **Prerequisites**

 These are the list of things you need to install these softwares.
 
 * [Fultter](http://flutter.dev/)
 * [Vs code](https://code.visualstudio.com/)
 * [Android studio](https://developer.android.com/studio)
 
 ## Setup Instructions

```
- Clone this repository:
$ git clone -b Article-Reader https://github.com/Deepak391/Flutter

- Enter in directory:
$ cd Flutter

- For install dependencies:
$ flutter packages get

- Run the app: 
$ flutter run 
```
 
 ### About App Features
 
- List of articles
- Search functionality
- Detail view
- Responsive UI
- Pull to refresh 
- Add Favourite articles
- Local save favourite articles 
 
 ## Tech Stack
- Flutter SDK: [3.7.0]
- State Management: [Getx]
- HTTP Client: [http]
- Persistence: [shared_preferences]
- Shimmer [Skeletonizer]

 ## State Management Explanation
  I have used Get statemanagement, which is one of the well know library which offers multiple things with full customization. 
  In app data is fecting from api and storing as a linst in controller and calling controller and passing data whereever is needed. 
  
## Known Issues / Limitations
  No big issue in app. only 1 minor thing is when we are in search bar click back doesnt remove focus from search bar. 
 
 ### Preview
 
 [Watch the Video](https://drive.google.com/file/d/1TI9wgiVQDWpp7KpEIi7pACp6sW8Kr9ME/preview)
 

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
