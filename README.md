# README

RuBB, a very minimal Rails-based forum for friends

Currently a work-in-progress that aims to be like [pgBoard](https://github.com/pgBoard/pgBoard) but in active development, and with even less features.

Deeply influenced by [Darius Kazemi's run your own social](https://runyourown.social/) and participating in the community that he describes, and many years spent on the internet. More on this and the aims of this project TK

## Guiding principles

These are a work-in-progress, but capture some of what has been guiding me:

* Enable collective decisionmaking
* Keep things small and intentional (do not assume or encourage scale, build tools that enable and rely on trust)
* As much as possible, keep one view of the forum so that all information is shared (eg don't allow custimization that would significantly change someone's experience)
* Do not privilege those with technical systems access (there is a lot baked into this, but essentially technical maintainers should not necessarily be the moderators)
* The forum does not make asks of your attention, but tries to give you tools manage your experience
* Keep the architecture conventional and maintenance as simple as possible. It shouldn't be a pain to maintain

## Features

The forum is constantly changing since it's under active development, but here are some features as of Jan 8, 2022, along with some current screenshots (it is easy to change the color scheme of the site and I do it frequently—-this is currently based off Zenburn).

Feature list:
* Account creation via Rake task
* Basic account management (setting profile, resetting password -- right now users can't change their email or username)
* Each person can invite one person each month
* Users can star threads to keep track of them, and see all their starred threads
* Users can pin threads so that they are easily found by entire forum (intended for onboarding / community things)
* Users can see when there are unread messages in a thread
* Users can mention others, and be visually notified when they have been mentioned in a thread

I've been running the forum at very low cost on Heroku (was free until database grew in size).

<img width="832" alt="Screen Shot 2022-01-08 at 9 54 00 AM" src="https://user-images.githubusercontent.com/3675092/148654812-3f12a8d6-ba28-4a2c-a095-8b52aa5d52d5.png">
<img width="930" alt="Screen Shot 2022-01-08 at 9 55 20 AM" src="https://user-images.githubusercontent.com/3675092/148654836-f34e7827-4f5c-46f9-b51b-d471bc2787f3.png">
<img width="930" alt="Screen Shot 2022-01-08 at 9 55 06 AM" src="https://user-images.githubusercontent.com/3675092/148654822-12817de1-34f9-4d8d-9f20-9763e62d043e.png">
<img width="930" alt="Screen Shot 2022-01-08 at 9 54 20 AM" src="https://user-images.githubusercontent.com/3675092/148654816-8b414989-f7f5-4c50-9ee0-c83c71a2f176.png">
<img width="930" alt="Screen Shot 2022-01-08 at 9 54 35 AM" src="https://user-images.githubusercontent.com/3675092/148654818-c576a930-4cfc-4cf0-8d86-0b76fe84efc1.png">
<img width="832" alt="Screen Shot 2022-01-08 at 9 53 38 AM" src="https://user-images.githubusercontent.com/3675092/148654829-76d770fe-657d-420d-a293-ed283d2604a3.png">

## Getting started

## Development

A development-specific Procfile is located at `Procfile.dev`. To run all processes locally, run:
```
heroku local -f Procfile.dev
```

or

```
bin/dev
```

## Contributing

I welcome contributions, but have pretty specific goals for this project so discourage submitting features without us discussing them first. I do keep sketches of things I'm considering and intend to tackle [in the issues](https://github.com/hartsick/ruBB/issues), and casually keep a running prioritized backlog [in this project](https://github.com/hartsick/ruBB/projects/2).

If you have an idea or one of the existing issues looks interesting to you (as bare as it may be), shoot me an email so we can talk! Or feel free to comment on an issue, if you'd prefer. I'd like to have a small set of interested developers that have same goals in mind rather than cultivating a wider set of contributors, so think that talking about those goals and ideas before someone contributes would be helpful.
