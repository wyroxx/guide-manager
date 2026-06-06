## The project

This is a Flutter application for managing guide excursions. Core features are authentication, profile with user data and stats, assigned excursions with horizontal calendar, applications management. The flow is the following: user creates an account, admin approves it, user can apply for excursions and see them in calendar. The app uses Firebase Authentication and Cloud Firestore as the backend.

## Project structure

```txt
lib/
  app/
    app.dart
    router.dart
    theme.dart
  core/
    utils/
    ui/ => reusable widgets and screens
  features/
    auth/
      data/
      domain/
      presentation/
    profile/
      data/
      domain/
      presentation/
    excursions/
      data/
      domain/
      presentation/
        widgets/
    applications/
      data/
      domain/
      presentation/
```

## Features

The project uses feature-first architecture with `/data`, `/domain` and `/presentation` layers. 
Excursions: the first page in the bottom navigation bar, has horizontal calendar with 21 scrollable days at the top and list of excursions for the selected day. The excursion card contains title, time, number of people, route, meeting place and additional info. 
Applications: the second page with the list of applications (pending and available), users can see applications only available for their level and with free slots. User cannot see applications from companies that blacklisted him.
Profile: the third page with guide's name, email, phone number, total tours completed and other data.
Auth: the app has login and register pages with proper validation of text fields. Router redirects the user if he is already logged in.

## Architecture rules

- Use feature-first structure.
- Each feature must contain `data`, `domain`, and `presentation` layers.
- UI must not access Firebase directly.
- Firebase queries must be placed only inside repositories.
- Domain layer must not import Flutter or Firebase packages.
- Presentation layer should use Riverpod providers/controllers.
- Use DTOs for Firestore mapping and domain entities for business logic.

## Firebase

Firestore contains three collections: `companies`, `guides` and `excursions`. Collection `companies` stores address, email, name, phone and banList - list with banned guides' emails. Collection `excursions` stores excursion-related data and may have subcollection `applications` with documents where each document is named with applied user email, the document contains `createdAt`, `email` and `status` (pending, accepted, rejected). Collection `guides` has all approved guides and user data for each guide.

```js
companies/{docId}
  address: string
  email: string
  createdAt: timestamp
  name: string
  phone: string
  banList: string[]

excursions/{docId}
  title: string
  excursionType: string
  maxParticipants: int64
  paymentStatus: "paid" | "unpaid"
  startsDate: timestamp
  endDate: timestamp
  route: string
  meetingPlace: string
  hasSpots: boolean
  requiredGuides: int64
  requiredLevels: string[]
  hasLunch: boolean
  hasMasterclass: boolean
  companyId: string
  assignedGuides: string[]

excursions/{excursionId}/applications/{guideEmail}
  createdAt: timestamp
  email: string
  status: "pending" | "accepted" | "rejected"

guides/{docId}
  name: string
  email: string
  phone: string
  level: string
  toursCount: number
  createdAt: timestamp
  bio: string
  avatar: string // avatar url
  telegramAlias: string
```

## Code conventions

- Use `AsyncValue` for loading/error/data states.
- Use `freezed` for immutable models when useful.
- Use enums instead of raw strings for statuses and levels.
- Do not use `print`; use proper logging or remove debug output.
- Keep widgets small and reusable.
- Prefer composition over large screen files.
- Avoid hardcoded colors, spacing and text styles.

## Do not do

- Do not overcomplicate architecture. Structure data-domain-presentation is enough, no need for `/pages` or `/usecases`
- Do not put Firebase queries inside widgets.
- Do not import Firebase packages in the domain layer.
- Do not compare statuses using raw strings in UI.
- Do not create large screen files with mixed UI, mapping, and business logic.
- Do not commit `.env`, service account files, keystores, or private keys.