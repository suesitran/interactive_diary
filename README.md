# interactive_diary

A mobile diary app that is as simple as recording emotion at anytime any place

## Code Coverage

[![codecov](https://codecov.io/gh/suesitran/interactive_diary/branch/dev/graph/badge.svg?token=A5CN9CRXPM)](https://codecov.io/gh/suesitran/interactive_diary)

## Setup project to run in your local machine:
Refer to this link how to setup and run your project: [Setup project](https://github.com/suesitran/interactive_diary/wiki/Contribute-to-this-project)

## Idea of Interactive Diary

This app is going to record daily activities in form of location checking and emotion sharing. It will keep track of user's location through out the day, and allow user to add emoji to each location, immediately when user is at the location, or later when user check their day activity at home.

The full idea of Interactive Diary can be summarized in this mindmap

![Interactive diary](https://user-images.githubusercontent.com/17781268/183034546-5c0d81ea-0abc-4090-bd11-6045ad9d6017.png)

There are 5 part of this project:

### Location (Where I was)
Location refers to user's current location at anything point of time during the day. This can be broken down as in mindmap below:

![Location](https://user-images.githubusercontent.com/17781268/183033198-64a61aea-5d65-484f-b051-1132c564a79d.png)

### Emotion and Diary writing (How I felt)
This is the main feature of ID, and it is tied losely to Location feature, which means, it still works even if location is not available.

![Diary](https://user-images.githubusercontent.com/17781268/183036122-dfcca9f9-0287-4cdf-b57f-ac9f7f7c16b5.png)

### Activity details (What I did)
This is a good to have feature, base on the type of location the user is in, there can be a prediction of what activity he can have there.

![Activities](https://user-images.githubusercontent.com/17781268/184794073-1ad93f39-2ceb-4b02-b929-bc074d8934eb.png)

### Authentication (Who am I)
Detail of Authentication can be found [here](https://github.com/suesitran/interactive_diary/issues/14)

Future: social network (Who I met)


### Timestamp (When it happend)
Can be treated as an attribute attached to all above info
