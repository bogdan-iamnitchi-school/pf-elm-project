module Model exposing (..)

import Html exposing (b, div, p, text)
import Model.Date as Date
import Model.Event as Event exposing (Event)
import Model.Event.Category exposing (EventCategory(..), SelectedEventCategories, allSelected)
import Model.Interval as Interval
import Model.PersonalDetails exposing (DetailWithName, PersonalDetails)
import Model.Repo exposing (Repo)


type alias Model =
    { personalDetails : PersonalDetails
    , events : List Event
    , selectedEventCategories : SelectedEventCategories
    , repos : List Repo
    }


academicEvents : List Event
academicEvents =
    [ { title = "Academic event 1"
      , interval = Interval.withDurationYears (Date.onlyYear 2016) 4
      , description = p [] [ text "I obtained ", b [] [ text "very" ], text " good grades." ]
      , category = Academic
      , url = Nothing
      , tags = []
      , important = False
      }
    , { title = "Academic event 2"
      , interval = Interval.withDurationYears (Date.onlyYear 2020) 2
      , description = div [] []
      , category = Academic
      , url = Nothing
      , tags = []
      , important = False
      }
    ]


workEvents : List Event
workEvents =
    [ { title = "Work event 1"
      , interval = Interval.withDurationMonths 2019 Date.Jun 3
      , description = text "Internship"
      , category = Work
      , url = Nothing
      , tags = []
      , important = False
      }
    , { title = "Work event 2"
      , interval = Interval.open (Date.full 2020 Date.Sep)
      , description = text "Junior position"
      , category = Work
      , url = Nothing
      , tags = []
      , important = False
      }
    ]


projectEvents : List Event
projectEvents =
    [ { title = "PF Elm Project"
      , interval = Interval.oneYear 2018
      , description = text "Portofolio Website Elm"
      , category = Project
      , url = Just "https://github.com/bogdan-iamnitchi-school/pf-elm-project"
      , tags = []
      , important = False
      }
    , { title = "Personal project 2"
      , interval = Interval.oneYear 2020
      , description = text "Command line utility in C"
      , category = Project
      , url = Nothing
      , tags = []
      , important = False
      }
    , { title = "Personal project 3"
      , interval = Interval.oneYear 2020
      , description = text "Movie database for License thesis"
      , category = Project
      , url = Nothing
      , tags = []
      , important = False
      }
    ]


personalDetails : PersonalDetails
personalDetails =
    { name = "Iamnitchi Bogdan - Computer Science Student"
    , intro = 
      """👋 Hello there! I'm Bogdan, a dedicated Computer Science enthusiast with a keen interest in the dynamic world of cybersecurity. As a student in the ever-evolving field of computer science, I am on a mission to blend theory with practical application to create innovative solutions for the digital landscape.
      💡 My journey in the realm of technology has been fueled by a passion for problem-solving and a deep curiosity about the intricacies of cybersecurity. From delving into the intricacies of cryptography to exploring the challenges of network security, I am continually fascinated by the evolving landscape of digital defense.
      🖥️ Armed with a solid foundation in computer science principles and a knack for cybersecurity intricacies, I embark on projects that not only showcase my technical skills but also contribute to the broader conversation about digital security. Whether it's coding elegant solutions or fortifying digital fortresses, I thrive on the challenges that this ever-shifting field presents.
      🔐 Join me on this exciting journey as I share my projects, insights, and experiences in the world of computer science and cybersecurity. Let's explore the possibilities of a secure and interconnected digital future together!"""
    , contacts = 
      [ DetailWithName "Phone Number" "0740953800"
      , DetailWithName "Personal Email" "b.iamnitchi@gmail.com"
      , DetailWithName "School Email" "iamnitchi.bogdan@student.utcluj.ro"
      ]
    , socials = 
      [ DetailWithName "Facebook" "https://www.facebook.com/bogdan.iamnitchi.77" 
      , DetailWithName "Instagram" "https://www.instagram.com/bogdaniamnitchi/" 
      , DetailWithName "GitHub" "https://github.com/BogdanIamnitchiSchool" 
      , DetailWithName "LinkedIn" "https://www.linkedin.com/in/bogdan-iamnitchi/" 
      ]
    }


initModel : Model
initModel =
    { personalDetails = personalDetails
    , events = Event.sortByInterval <| academicEvents ++ workEvents ++ projectEvents
    , selectedEventCategories = allSelected
    , repos = []
    }
