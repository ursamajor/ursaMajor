Responsibilities

  - Josh: clean up / back-end
  - Sean: rules / back-end
  - Dibyo / Victoria: front-end / UI

Landing Page

  - [ ] tag line
  - [ ] highlights

Course Catalog

  - [ ] show remaining requirements unsatisfied in course catalog, click to display courses that satisfy, show course that will fulfill multiple requirements
  - [ ] fix column widths

Plan Page

  - [ ] start tutorial after rules properly loaded (pop up with start tutorial button)
  - [ ] print option
    - [ ] https://ariejan.net/2007/01/19/print-this-page-with-ruby-on-rails/
  - [ ] mobile options
    - [ ] drop down of semester to add course to in left column
    - [ ] slider to switch between semesters (where backpack is)
    - [ ] dropdown course moving breaks if you move things to garbage
      - [ ] $scope.courses becomes messed up when pushing course to it
      - [ ] disable dropdown to garbage for now
  - [ ] in course modal, show which requirements satisfies
  - [ ] display rule description in modal, plus courses that satisfy
  - [ ] ability to move courses within a semester around
  - [ ] ability to hide a year
  - [ ] for demo, allow saving plan to user's plans if logged in
  - [ ] sort by tabs (university, college, major)

Rules Page

Profile Page

  - [ ] allow input of grades, display gpa overall/per semester
  - [ ] user information (GPA, transcripts, major)

Contact

  - [ ] bug reporting (firebase?)

Courses

  - [ ] save dept name as field
  - [ ] prerequisites
  - [ ] only show show more/less if it's been abbreviated
  - [ ] editing of course info in ui

Rules

  - [ ] get college/major info for rule from folder structure/name
  - [ ] online/summer versions of classes should also work with rules
  - [ ] updating rule (can only use up to 2 from same dept for breadths)
  - [ ] remove course if used for rule and can only be used once
    - [ ] all different combinations to decide which one to remove/use for a certain rule
      - [ ] utility function of numRulesSatisfied, proportion of courses left to fulfill other requirements
    - [ ] flag as an exclusive rule, which removes course from plan when checking rest

Plans

  - [ ] autopopulate plans from user information (years of semester)
  - [ ] selecting which rules you want
  - [ ] share plan
    - [ ] public flag
    - [ ] allow nonowners to see if flag
    - [ ] if nonowner, no drag/drop
    - [ ] maybe don't show rules?
    - [ ] don't show garbage

Semesters

  - [ ] semester object should have year+fa/sp/su

Users

  - [ ] save default major, semester/year start
  - [ ] delete courses (admin)
  - [ ] current plan field

Chores

  - [ ] going through completed rules, make sure they work
  - [ ] documentation 
    - [ ] refer to (http://stackoverflow.com/questions/2543979/example-of-a-well-documented-rails-project-and-or-best-pratices)
    - [ ] more swagger
  - [ ] tag rules by major
  - [ ] clean up planscontroller
  - [ ] more progressive data-ng-cloak
  - [ ] tests
  
AB Testing framework

  - [ ] tokens

After First Release

  - [ ] sample major plan
  - [ ] when a course is offered
  - [ ] able to flag a course under a certain rule
  - [ ] handle ap/transfer
  - [ ] UI for editing rules/yaml
  - [ ] ability to add more semesters
  - [ ] handling more than one major
  - [ ] handling variable unit courses
  - [ ] labeling pnp courses

Possible Features

  - [ ] popular rules
  - [ ] switch plans without reload
  - [ ] ninjacourses/courserank semesterly calendar
  - [ ] color code rules/courses (breadth, major, university)
  - [ ] different gradients for semesters
  - [ ] user picks color of classes, heavier load can tell by color (based on #units, diff reqs, etc)

Layout [Optional]

  - [ ] colors for flash messages

Course Filtering [Optional]

  - [ ] filter by course name first, then by title
  - [ ] query partial matches across spaces
  - [ ] sort courses beforehand in rails
  - [ ] more efficient -> place garbage course in right place instead of sorting everything
  - [ ] maybe don't use .concat?
  - [ ] alphabetically sort course when swapping between query list and ones already in plan

Rule Checking [Optional]

  - [ ] make front-end checking more efficient
    - [ ] fail fast
    - [ ] check subrules at same time as main rule

Angular [Optional]

  - [ ] more consistent json object attribute accessing [] vs .
  - [ ] separate courses and plans controller again (combined for sake of duplicate removal)
  - [ ] switch over bootstrap js to angular ui js
  - [ ] set default values for models set by promises/functions
  - [ ] make sure that requests in order (don't compute on null values)
  - [ ] data-ng-if

Rails [Optional]

  - [ ] clean up / comment out parts replaced by angular
  - [ ] naming convention for partials (stick to camel or snake case)
  - [ ] rake tasks

Performance [Optional]

  - [ ] maybe don't load everything at once and rely on http requests
    - [ ] other majors?
    - [ ] course modal information?
  - [ ] maybe instead of passing full name of rule, pass rule ids
    - [ ] for numcourses/units, compare tagged ids with rule id
    - [ ] for course rule, pass course id with rule
    - [ ] pass rule id with rule otherwise
  - [ ] serialize tags as a string instead of x associations

Errors

  - [ ] 404 not found - delete after checking
  - [ ] Courses that don't work:
    - [ ] AGR CHM.299
    - [ ] BUDDSTD.98 99 C174
    - [ ] CHINESE.180 39 90
    - [ ] EA LANG.39A 39B 39C 39D 39E 39F 39G 39H 39I 39J 39K 39L 39M 39N 39O 39P 39Q 39R 39S 39T 39U 39V 39W 39X 39Y 39Z 98
    - [ ] EDUC.283C
    - [ ] EL ENG.C227A C227B
    - [ ] IAS.105 105A 105B 115 155AC 156 20
    - [ ] INFO.207 211 24 271A 297 39 39A 39B 39C 39D 39E 39F 39G 39H 39I 39J 39K 39L 39M 39N 39O 39P 39Q 39R 39S 39T 39U 39V 39W 39X 39Y 39Z W290X W290Y
    - [ ] INTEGBI.144 C139
    - [ ] JAPAN.39 C174
    - [ ] KOREAN.H195A H195B
    - [ ] MCELLBI.110L 113 135 230X 241 247 254 282 297 61 64
    - [ ] NUC ENG.290B 290G 290H 290J
    - [ ] PLANTBI.160L C246
    - [ ] PSYCH.C112 C204
    - [ ] SOC WEL.300
    - [ ] UGIS.161 162B 162C 162D 162F 171
